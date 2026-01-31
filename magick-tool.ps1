Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Magick Batch Pro v3.0" Height="650" Width="500" Background="#1e1e1e">
    <StackPanel Margin="20">
        <TextBlock Text="ImageMagick Multi-Tool" FontSize="22" Foreground="#0078d4" HorizontalAlignment="Center" Margin="0,0,0,15"/>
        
        <Button Name="btnFolder" Content="1. Select Source Folder" Height="35" Background="#333" Foreground="White"/>
        <TextBlock Name="txtFolderPath" Text="No folder selected..." Foreground="#888" FontSize="10" Margin="0,5,0,10" TextAlignment="Center"/>

        <TextBlock Text="2. Filter (e.g. *.jpg or 1-5)" Foreground="White" Margin="0,5"/>
        <TextBox Name="txtFilter" Text="*.jpg" Height="25" Background="#2d2d2d" Foreground="White" Padding="3" ToolTip="Wildcards or ranges like 1-10 allowed."/>

        <TextBlock Text="3. Select Action:" Foreground="White" Margin="0,15,0,5"/>
        <ComboBox Name="comboAction" ToolTip="What do you want to do to these images?">
            <ComboBoxItem Content="Resize for Print (A4/Letter)" IsSelected="True"/>
            <ComboBoxItem Content="Rotate 90° Clockwise"/>
            <ComboBoxItem Content="Flip Vertically"/>
            <ComboBoxItem Content="Center Crop (50%)"/>
            <ComboBoxItem Content="Convert to PNG"/>
        </ComboBox>

        <Grid Name="gridPrintOptions" Margin="0,10">
            <Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
            <StackPanel Margin="5">
                <TextBlock Text="Paper Size:" Foreground="White"/>
                <ComboBox Name="comboSize">
                    <ComboBoxItem Content="A4 (210x297mm)" IsSelected="True"/><ComboBoxItem Content="Letter (8.5x11in)"/>
                </ComboBox>
            </StackPanel>
            <StackPanel Margin="5" Grid.Column="1">
                <TextBlock Text="DPI:" Foreground="White"/>
                <ComboBox Name="comboDPI">
                    <ComboBoxItem Content="300" IsSelected="True"/><ComboBoxItem Content="600"/><ComboBoxItem Content="72"/>
                </ComboBox>
            </StackPanel>
        </Grid>

        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10">
            <RadioButton Name="rbLegacy" Content="PS 5.1" Foreground="White" IsChecked="True" Margin="10,0"/>
            <RadioButton Name="rbParallel" Content="PS 7+ (Parallel)" Foreground="White"/>
        </StackPanel>

        <Button Name="btnRun" Content="RUN BATCH PROCESS" Height="50" Background="#28a745" Foreground="White" FontWeight="Bold" Margin="0,10"/>
        
        <ProgressBar Name="progBar" Height="15" Margin="0,10,0,5" Foreground="#0078d4"/>
        <TextBlock Name="txtStatus" Text="Ready" Foreground="#aaa" HorizontalAlignment="Center"/>
    </StackPanel>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- Mapping ---
$btnFolder = $window.FindName("btnFolder"); $txtFolderPath = $window.FindName("txtFolderPath")
$txtFilter = $window.FindName("txtFilter"); $btnRun = $window.FindName("btnRun")
$comboAction = $window.FindName("comboAction"); $gridPrintOptions = $window.FindName("gridPrintOptions")
$comboSize = $window.FindName("comboSize"); $comboDPI = $window.FindName("comboDPI")
$progBar = $window.FindName("progBar"); $txtStatus = $window.FindName("txtStatus")
$rbParallel = $window.FindName("rbParallel")

# Hide/Show Print options based on selection
$comboAction.Add_SelectionChanged({
    if ($comboAction.SelectedItem.Content -match "Resize") { $gridPrintOptions.Visibility = "Visible" }
    else { $gridPrintOptions.Visibility = "Collapsed" }
})

$script:sourceDir = ""
$btnFolder.Add_Click({
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($dlg.ShowDialog() -eq "OK") { $script:sourceDir = $dlg.SelectedPath; $txtFolderPath.Text = $script:sourceDir }
})

function Get-FilteredFiles {
    param($dir, $inputStr)
    $allFiles = Get-ChildItem -Path $dir -File
    if ($inputStr -like "*.*") { return Get-ChildItem -Path $dir -Filter $inputStr }
    $indices = New-Object System.Collections.Generic.List[int]
    $inputStr.Split(',') | ForEach-Object {
        $part = $_.Trim()
        if ($part -match '(\d+)-(\d+)') { for ($i = [int]$matches[1]; $i -le [int]$matches[2]; $i++) { $indices.Add($i) } }
        elseif ($part -match '^\d+$') { $indices.Add([int]$part) }
    }
    return $allFiles | Where-Object { 
        $nameOnly = $_.BaseName
        if ($nameOnly -match '^\d+$') { $indices -contains [int]$nameOnly }
        elseif ($nameOnly -match '\((\d+)\)') { $indices -contains [int]$matches[1] }
    }
}

$btnRun.Add_Click({
    if (-not $script:sourceDir) { [System.Windows.MessageBox]::Show("Folder first!"); return }
    $files = Get-FilteredFiles $script:sourceDir $txtFilter.Text
    
    # Determine Command
    $action = $comboAction.SelectedItem.Content
    $dpi = $comboDPI.Text
    $size = $comboSize.Text
    switch -wildcard ($size) { "*A4*" { $w=8.27; $h=11.69 } "*Letter*" { $w=8.5; $h=11.0 } }
    $pxW = [int]($w * $dpi); $pxH = [int]($h * $dpi)

    $magickArgs = switch ($action) {
        "Resize for Print (A4/Letter)" { "-resize $($pxW)x$($pxH) -background white -gravity center -extent $($pxW)x$($pxH) -density $dpi -units pixelsperinch" }
        "Rotate 90° Clockwise"         { "-rotate 90" }
        "Flip Vertically"              { "-flip" }
        "Center Crop (50%)"            { "-gravity center -crop 50%x50%+0+0 +repage" }
        "Convert to PNG"               { "" } # Handled by extension change
    }

    $progBar.Maximum = $files.Count
    $progBar.Value = 0

    foreach ($file in $files) {
        $ext = if ($action -eq "Convert to PNG") { ".png" } else { $file.Extension }
        $outPath = Join-Path $script:sourceDir "Edit_$($file.BaseName)$($ext)"
        
        Start-Process magick -ArgumentList "`"$($file.FullName)`" $magickArgs `"$outPath`"" -Wait -NoNewWindow
        $progBar.Value++
        [System.Windows.Forms.Application]::DoEvents()
    }
    $txtStatus.Text = "Done! Processed $($files.Count) files."
})

$window.ShowDialog() | Out-Null
