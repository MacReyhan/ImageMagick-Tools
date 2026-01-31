# --- ADMIN AUTO-LAUNCH ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="ULTIMATE WINDOWS GOD MODE - 2026" Height="880" Width="1250" 
        Background="#0A0A0A" WindowStartupLocation="CenterScreen" ResizeMode="NoResize">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Margin="0,0,0,20">
            <TextBlock Text="ULTIMATE WINDOWS GOD MODE" FontSize="32" Foreground="#00ffcc" HorizontalAlignment="Center" FontWeight="Bold"/>
            <TextBlock Text="NETWORK &amp; UI TOOLS ADDED ✅" FontSize="12" Foreground="#4CAF50" HorizontalAlignment="Center"/>
        </StackPanel>

        <UniformGrid Grid.Row="1" Columns="5">
            <StackPanel Margin="8">
                <TextBlock Text="🛠️ SYSTEM &amp; NET" Foreground="Yellow" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn1" Content="Massgrave" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn4" Content="SFC + DISM" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btnNetReset" Content="🌐 RESET NETWORK" Margin="0,5,0,2" Padding="6" Background="#8B0000" Foreground="White" FontWeight="Bold"/>
                <TextBlock Text="🧹 CLEANUP" Foreground="Yellow" FontWeight="Bold" Margin="0,15,0,10"/>
                <Button Name="btn5" Content="WizTree" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn6" Content="BCUninstaller" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="8">
                <TextBlock Text="⚡ UTILITIES" Foreground="#00CCFF" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnTwinkle" Content="Twinkle Tray (Bright)" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btnNerdFont" Content="Install Nerd Font" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn9" Content="Everything" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn11" Content="PowerToys" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn13" Content="AutoHotkey v2" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="8">
                <TextBlock Text="👨‍💻 MCA DEV" Foreground="#A0FE00" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn14" Content="VS Code" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn17" Content="Node.js LTS" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn18" Content="Python 3" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn19" Content="WSL 2" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="8">
                <TextBlock Text="🏠 HOMELAB" Foreground="#FF00FF" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnTailscale" Content="Tailscale" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btnRustDesk" Content="RustDesk" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btnPingVM" Content="Ping VMLinux" Margin="0,2" Padding="4" Background="#333" Foreground="#FF00FF"/>
                <Button Name="btnPingGCS" Content="Ping GCSLinux" Margin="0,2" Padding="4" Background="#333" Foreground="#FF00FF"/>
            </StackPanel>

            <StackPanel Margin="8">
                <TextBlock Text="🎮 HARDWARE" Foreground="Orange" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btn21" Content="FanControl" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <Button Name="btn23" Content="MSI Afterburner" Margin="0,2" Padding="4" Background="#252525" Foreground="White"/>
                <TextBlock Text="🚀 MAINTENANCE" Foreground="Orange" FontWeight="Bold" Margin="0,15,0,10"/>
                <Button Name="btn25" Content="UPGRADE ALL" Margin="0,2" Padding="10" Background="#005a9e" Foreground="White" FontWeight="Bold"/>
            </StackPanel>
        </UniformGrid>

        <StatusBar Grid.Row="2" Background="#1e1e1e" Foreground="White" Height="30">
            <TextBlock Name="txtStatus" Text="Ready, Sayan." VerticalAlignment="Center" Margin="10,0"/>
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

# --- NEW MAPPINGS ---
$btn.btnTwinkle.Add_Click({ Run-Task "Twinkle Tray" "winget install --id XanderFrangos.TwinkleTray -e" })

$btn.btnNetReset.Add_Click({ 
    Run-Task "Network Reset" "netsh winsock reset; netsh int ip reset; ipconfig /release; ipconfig /renew; ipconfig /flushdns" 
})

$btn.btnNerdFont.Add_Click({ 
    Run-Task "JetBrains Nerd Font" "winget install --id GitHub.NerdFonts.JetBrainsMono -e" 
})

# --- EXISTING MAPPINGS ---
$btn.btn1.Add_Click({ Run-Task "Massgrave" "irm https://get.activated.win | iex" })
$btn.btn4.Add_Click({ Run-Task "Health Check" "sfc /scannow; DISM /Online /Cleanup-Image /RestoreHealth" })
$btn.btn5.Add_Click({ Run-Task "WizTree" "winget install --id AntibodySoftware.WizTree -e" })
$btn.btn6.Add_Click({ Run-Task "BCU" "winget install --id Klocman.BulkCrapUninstaller -e" })
$btn.btn9.Add_Click({ Run-Task "Everything" "winget install --id voidtools.Everything -e" })
$btn.btn11.Add_Click({ Run-Task "PowerToys" "winget install --id Microsoft.PowerToys -e" })
$btn.btn13.Add_Click({ Run-Task "AutoHotkey" "winget install --id AutoHotkey.AutoHotkey -e" })
$btn.btn14.Add_Click({ Run-Task "VS Code" "winget install --id Microsoft.VisualStudioCode -e" })
$btn.btn17.Add_Click({ Run-Task "Node.js" "winget install --id OpenJS.NodeJS.LTS -e" })
$btn.btn18.Add_Click({ Run-Task "Python" "winget install --id Python.Python.3 -e" })
$btn.btn19.Add_Click({ Run-Task "WSL 2" "wsl --install" })
$btn.btn21.Add_Click({ Run-Task "FanControl" "winget install --id Rem0o.FanControl.V2 -e" })
$btn.btn23.Add_Click({ Run-Task "Afterburner" "winget install --id Guru3D.Afterburner -e" })
$btn.btn25.Add_Click({ Run-Task "Update All" "winget upgrade --all --include-unknown" })
$btn.btnTailscale.Add_Click({ Run-Task "Tailscale" "winget install --id Tailscale.Tailscale -e" })
$btn.btnRustDesk.Add_Click({ Run-Task "RustDesk" "winget install --id RustDesk.RustDesk -e" })
$btn.btnPingVM.Add_Click({ Run-Task "Ping VMLinux" "ping VMLinux -n 5; pause" })
$btn.btnPingGCS.Add_Click({ Run-Task "Ping GCSLinux" "ping GCSLinux -n 5; pause" })

$Form.ShowDialog() | Out-Null
