# --- ADMIN AUTO-LAUNCH ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="ULTIMATE WINDOWS GOD MODE - 2026" Height="850" Width="1100" 
        Background="#121212" WindowStartupLocation="CenterScreen" ResizeMode="NoResize">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Margin="0,0,0,20">
            <TextBlock Text="ULTIMATE WINDOWS GOD MODE" FontSize="32" Foreground="#00ffcc" HorizontalAlignment="Center" FontWeight="Bold"/>
            <TextBlock Text="ADMIN PRIVILEGES GRANTED ✅" FontSize="12" Foreground="#4CAF50" HorizontalAlignment="Center"/>
        </StackPanel>

        <UniformGrid Grid.Row="1" Columns="4">
            <StackPanel Margin="10">
                <TextBlock Text="🛠️ SYSTEM CORE" Foreground="Yellow" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn1" Content="Massgrave (Activate)" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn2" Content="Chris Titus Utility" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn3" Content="Repair Winget" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn4" Content="System Health Check" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                
                <TextBlock Text="🧹 CLEANUP" Foreground="Yellow" FontWeight="Bold" Margin="0,15,0,10"/>
                <Button Name="btn5" Content="WizTree" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn6" Content="BCUninstaller" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn7" Content="BleachBit" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn8" Content="O&amp;O ShutUp10++" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="10">
                <TextBlock Text="⚡ UTILITIES" Foreground="#00CCFF" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn9" Content="Everything Search" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn10" Content="QuickLook" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn11" Content="PowerToys" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn12" Content="Flow Launcher" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn13" Content="AutoHotkey v2" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn26" Content="Brave Browser" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="10">
                <TextBlock Text="👨‍💻 DEV ENV (MCA)" Foreground="#A0FE00" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn14" Content="VS Code" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn15" Content="Git &amp; GitHub" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn16" Content="Docker Desktop" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn17" Content="Node.js LTS" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn18" Content="Python 3" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn19" Content="WSL 2" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn20" Content="Postman" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="10">
                <TextBlock Text="🎮 HARDWARE" Foreground="Orange" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn21" Content="FanControl" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn22" Content="HWiNFO64" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn23" Content="MSI Afterburner" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btn24" Content="CrystalDiskInfo" Margin="0,3" Padding="5" Background="#252525" Foreground="White"/>
                
                <TextBlock Text="🚀 MAINTENANCE" Foreground="Orange" FontWeight="Bold" Margin="0,15,0,10"/>
                <Button Name="btn25" Content="UPGRADE ALL APPS" Margin="0,3" Padding="10" Background="#005a9e" Foreground="White" FontWeight="Bold"/>
            </StackPanel>
        </UniformGrid>

        <StatusBar Grid.Row="2" Background="#1e1e1e" Foreground="White" Height="30">
            <TextBlock Name="txtStatus" Text="Ready for action, bro." VerticalAlignment="Center" Margin="10,0"/>
        </StatusBar>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$Form = [Windows.Markup.XamlReader]::Load($reader)
$btn = @{}; $xaml.SelectNodes("//*[@Name]") | ForEach-Object { $btn[$_.Name] = $Form.FindName($_.Name) }
$txtStatus = $Form.FindName("txtStatus")

function Run-Task ($msg, $cmd) {
    $txtStatus.Text = "Status: $msg..."
    Start-Process powershell -ArgumentList "-NoProfile -Command $cmd" -Wait
    $txtStatus.Text = "Status: Finished $msg ✅"
}

# --- ALL 26 BUTTON MAPPINGS ---
$btn.btn1.Add_Click({ Run-Task "Massgrave" "irm https://get.activated.win | iex" })
$btn.btn2.Add_Click({ Run-Task "Chris Titus" "irm https://christitus.com/win | iex" })
$btn.btn3.Add_Click({ Run-Task "Repair Winget" "winget source reset --force; winget source update" })
$btn.btn4.Add_Click({ Run-Task "Health Check" "sfc /scannow; DISM /Online /Cleanup-Image /RestoreHealth" })
$btn.btn5.Add_Click({ Run-Task "WizTree" "winget install --id AntibodySoftware.WizTree -e" })
$btn.btn6.Add_Click({ Run-Task "BCU" "winget install --id Klocman.BulkCrapUninstaller -e" })
$btn.btn7.Add_Click({ Run-Task "BleachBit" "winget install --id BleachBit.BleachBit -e" })
$btn.btn8.Add_Click({ Run-Task "O&O ShutUp10" "winget install --id OandO.ShutUp10 -e" })
$btn.btn9.Add_Click({ Run-Task "Everything" "winget install --id voidtools.Everything -e" })
$btn.btn10.Add_Click({ Run-Task "QuickLook" "winget install --id QL-Win.QuickLook -e" })
$btn.btn11.Add_Click({ Run-Task "PowerToys" "winget install --id Microsoft.PowerToys -e" })
$btn.btn12.Add_Click({ Run-Task "Flow Launcher" "winget install --id Flow-Launcher.Flow-Launcher -e" })
$btn.btn13.Add_Click({ Run-Task "AutoHotkey" "winget install --id AutoHotkey.AutoHotkey -e" })
$btn.btn14.Add_Click({ Run-Task "VS Code" "winget install --id Microsoft.VisualStudioCode -e" })
$btn.btn15.Add_Click({ Run-Task "Git/GitHub" "winget install --id Git.Git -e; winget install --id GitHub.Desktop -e" })
$btn.btn16.Add_Click({ Run-Task "Docker" "winget install --id Docker.DockerDesktop -e" })
$btn.btn17.Add_Click({ Run-Task "Node.js" "winget install --id OpenJS.NodeJS.LTS -e" })
$btn.btn18.Add_Click({ Run-Task "Python" "winget install --id Python.Python.3 -e" })
$btn.btn19.Add_Click({ Run-Task "WSL 2" "wsl --install" })
$btn.btn20.Add_Click({ Run-Task "Postman" "winget install --id Postman.Postman -e" })
$btn.btn21.Add_Click({ Run-Task "FanControl" "winget install --id Rem0o.FanControl.V2 -e" })
$btn.btn22.Add_Click({ Run-Task "HWiNFO64" "winget install --id Realix.HWiNFO -e" })
$btn.btn23.Add_Click({ Run-Task "Afterburner" "winget install --id Guru3D.Afterburner -e" })
$btn.btn24.Add_Click({ Run-Task "CrystalDiskInfo" "winget install --id CrystalDewWorld.CrystalDiskInfo -e" })
$btn.btn25.Add_Click({ Run-Task "Update All" "winget upgrade --all --include-unknown" })
$btn.btn26.Add_Click({ Run-Task "Brave" "winget install --id Brave.Brave -e" })

$Form.ShowDialog() | Out-Null
