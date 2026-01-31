# --- ADMIN AUTO-LAUNCH ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="ULTIMATE WINDOWS GOD MODE - 2026" Height="920" Width="1400" 
        Background="#050505" WindowStartupLocation="CenterScreen" ResizeMode="NoResize">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Margin="0,0,0,10">
            <TextBlock Text="ULTIMATE WINDOWS GOD MODE" FontSize="34" Foreground="#00ffcc" HorizontalAlignment="Center" FontWeight="Bold"/>
            <TextBlock Text="MASTER CONSOLE - FINAL VERSION" FontSize="12" Foreground="#888" HorizontalAlignment="Center"/>
        </StackPanel>

        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,0,0,20">
            <TextBlock Text="INSTALLER ENGINE:" Foreground="White" VerticalAlignment="Center" Margin="0,0,15,0" FontWeight="Bold"/>
            <Button Name="btnToggleEngine" Content="SWITCH TO CHOCOLATEY 🍫" Width="250" Padding="10" Background="#005a9e" Foreground="White" FontWeight="Bold"/>
        </StackPanel>

        <UniformGrid Grid.Row="2" Columns="6">
            <StackPanel Margin="5">
                <TextBlock Text="🛠️ SYSTEM CORE" Foreground="Yellow" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnMassgrave" Content="Massgrave" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnCTT" Content="Chris Titus Utility" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnHealth" Content="SFC + DISM" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnNetReset" Content="🌐 NET RESET" Margin="0,10,0,2" Padding="8" Background="#8B0000" Foreground="White" FontWeight="Bold"/>
                <TextBlock Text="🧹 CLEANUP" Foreground="Yellow" FontWeight="Bold" Margin="0,15,0,10"/>
                <Button Name="btnWizTree" Content="WizTree" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnBCU" Content="BCUninstaller" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="5">
                <TextBlock Text="⚡ UTILITIES" Foreground="#00CCFF" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnTwinkle" Content="Twinkle Tray" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnNerdFont" Content="Nerd Font" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnEverything" Content="Everything" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnPowerToys" Content="PowerToys" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnAHK" Content="AutoHotkey v2" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnBrave" Content="Brave Browser" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="5">
                <TextBlock Text="👨‍💻 MCA DEV" Foreground="#A0FE00" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnVSCode" Content="VS Code" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnNode" Content="Node.js LTS" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnPython" Content="Python 3" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnWSL" Content="WSL 2" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnPostman" Content="Postman" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnGit" Content="Git + GitHub" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="5">
                <TextBlock Text="🏠 HOMELAB" Foreground="#FF00FF" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnTailscale" Content="Tailscale" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnRustDesk" Content="RustDesk" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnPingVM" Content="Ping VMLinux" Margin="0,10,0,2" Padding="5" Background="#333" Foreground="#FF00FF"/>
                <Button Name="btnPingGCS" Content="Ping GCSLinux" Margin="0,2,0,2" Padding="5" Background="#333" Foreground="#FF00FF"/>
            </StackPanel>

            <StackPanel Margin="5">
                <TextBlock Text="🔥 ACTIONS" Foreground="Orange" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnWorkMode" Content="💼 WORK MODE" Margin="0,2" Padding="8" Background="#008080" Foreground="White" FontWeight="Bold"/>
                <Button Name="btnBackup" Content="📁 BACKUP CONFIGS" Margin="0,2" Padding="8" Background="#4B0082" Foreground="White" FontWeight="Bold"/>
                <Button Name="btnSearch" Content="🔍 SEARCH PACKS" Margin="0,15,0,2" Padding="6" Background="#252525" Foreground="White"/>
            </StackPanel>

            <StackPanel Margin="5">
                <TextBlock Text="🎮 HARDWARE" Foreground="Tomato" FontWeight="Bold" Margin="0,0,0,10"/>
                <Button Name="btnFan" Content="FanControl" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnMSI" Content="MSI Afterburner" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnHW" Content="HWiNFO64" Margin="0,2" Padding="5" Background="#252525" Foreground="White"/>
                <Button Name="btnUpgradeAll" Content="UPGRADE ALL" Margin="0,20,0,0" Padding="12" Background="#005a9e" Foreground="White" FontWeight="Bold"/>
            </StackPanel>
        </UniformGrid>

        <StatusBar Grid.Row="3" Background="#111" Foreground="White" Height="35">
            <TextBlock Name="txtStatus" Text="Engine: WINGET | Ready for action, Sayan." VerticalAlignment="Center" Margin="10,0"/>
        </StatusBar>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$Form = [Windows.Markup.XamlReader]::Load($reader)
$btn = @{}; $xaml.SelectNodes("//*[@Name]") | ForEach-Object { $btn[$_.Name] = $Form.FindName($_.Name) }
$txtStatus = $Form.FindName("txtStatus")

# --- ENGINE STATE ---
$global:CurrentEngine = "Winget"

function Run-LiveTask ($msg, $wingetCmd, $chocoCmd) {
    $cmd = if ($global:CurrentEngine -eq "Winget") { $wingetCmd } else { $chocoCmd }
    $txtStatus.Text = "Status: Running $msg via $($global:CurrentEngine)..."
    Invoke-Expression $cmd
    $txtStatus.Text = "Status: Finished $msg ✅"
}

# --- TOGGLE LOGIC ---
$btn.btnToggleEngine.Add_Click({
    if ($global:CurrentEngine -eq "Winget") {
        $global:CurrentEngine = "Choco"
        $this.Content = "SWITCH TO WINGET 📦"
        $this.Background = "#7b3f00"
        $btn.btnUpgradeAll.Background = "#7b3f00"
        $txtStatus.Text = "Engine: CHOCOLATEY | Ready, Sayan."
    } else {
        $global:CurrentEngine = "Winget"
        $this.Content = "SWITCH TO CHOCOLATEY 🍫"
        $this.Background = "#005a9e"
        $btn.btnUpgradeAll.Background = "#005a9e"
        $txtStatus.Text = "Engine: WINGET | Ready, Sayan."
    }
})

# --- DUAL MAPPINGS ---
$btn.btnUpgradeAll.Add_Click({ Run-LiveTask "Upgrade All" "winget upgrade --all" "choco upgrade all -y" })
$btn.btnVSCode.Add_Click({ Run-LiveTask "VS Code" "winget install Microsoft.VisualStudioCode -e" "choco install vscode -y" })
$btn.btnNode.Add_Click({ Run-LiveTask "Node.js" "winget install OpenJS.NodeJS.LTS -e" "choco install nodejs-lts -y" })
$btn.btnPython.Add_Click({ Run-LiveTask "Python" "winget install Python.Python.3 -e" "choco install python -y" })
$btn.btnPostman.Add_Click({ Run-LiveTask "Postman" "winget install Postman.Postman -e" "choco install postman -y" })
$btn.btnGit.Add_Click({ Run-LiveTask "Git" "winget install Git.Git -e" "choco install git -y" })
$btn.btnBrave.Add_Click({ Run-LiveTask "Brave" "winget install Brave.Brave -e" "choco install brave -y" })
$btn.btnTailscale.Add_Click({ Run-LiveTask "Tailscale" "winget install Tailscale.Tailscale -e" "choco install tailscale -y" })
$btn.btnRustDesk.Add_Click({ Run-LiveTask "RustDesk" "winget install RustDesk.RustDesk -e" "choco install rustdesk -y" })
$btn.btnTwinkle.Add_Click({ Run-LiveTask "Twinkle Tray" "winget install XanderFrangos.TwinkleTray -e" "choco install twinkle-tray -y" })
$btn.btnNerdFont.Add_Click({ Run-LiveTask "Nerd Font" "winget install GitHub.NerdFonts.JetBrainsMono -e" "choco install jetbrainsmono-nerdfont -y" })
$btn.btnEverything.Add_Click({ Run-LiveTask "Everything" "winget install voidtools.Everything -e" "choco install everything -y" })
$btn.btnPowerToys.Add_Click({ Run-LiveTask "PowerToys" "winget install Microsoft.PowerToys -e" "choco install powertoys -y" })
$btn.btnAHK.Add_Click({ Run-LiveTask "AHK" "winget install AutoHotkey.AutoHotkey -e" "choco install autohotkey -y" })
$btn.btnWizTree.Add_Click({ Run-LiveTask "WizTree" "winget install AntibodySoftware.WizTree -e" "choco install wiztree -y" })
$btn.btnBCU.Add_Click({ Run-LiveTask "BCU" "winget install Klocman.BulkCrapUninstaller -e" "choco install bcu -y" })
$btn.btnFan.Add_Click({ Run-LiveTask "FanControl" "winget install Rem0o.FanControl.V2 -e" "choco install fancontrol -y" })
$btn.btnMSI.Add_Click({ Run-LiveTask "Afterburner" "winget install Guru3D.Afterburner -e" "choco install msiafterburner -y" })
$btn.btnHW.Add_Click({ Run-LiveTask "HWiNFO" "winget install Realix.HWiNFO -e" "choco install hwinfo.install -y" })

# --- NATIVE SCRIPTS ---
$btn.btnMassgrave.Add_Click({ Invoke-Expression "irm https://get.activated.win | iex" })
$btn.btnCTT.Add_Click({ Invoke-Expression "irm https://christitus.com/win | iex" })
$btn.btnHealth.Add_Click({ Invoke-Expression "sfc /scannow; DISM /Online /Cleanup-Image /RestoreHealth; pause" })
$btn.btnNetReset.Add_Click({ Invoke-Expression "netsh winsock reset; netsh int ip reset; ipconfig /flushdns; pause" })
$btn.btnWSL.Add_Click({ Invoke-Expression "wsl --install; pause" })
$btn.btnPingVM.Add_Click({ Invoke-Expression "ping VMLinux -n 5; pause" })
$btn.btnPingGCS.Add_Click({ Invoke-Expression "ping GCSLinux -n 5; pause" })

# --- SPECIAL ACTIONS ---
$btn.btnBackup.Add_Click({
    $backupDir = "$HOME\Desktop\Sayan_Backups"
    if (!(Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir }
    if (Test-Path $PROFILE) { Copy-Item $PROFILE -Destination "$backupDir\PowerShell_Profile.ps1" -Force }
    $txtStatus.Text = "Profile backed up to Desktop! 📁"
})

$btn.btnWorkMode.Add_Click({
    Start-Process "https://www.flipkart.com"
    Start-Process "wt.exe"
    $txtStatus.Text = "Work Mode: Launched! 💼"
})

$Form.ShowDialog() | Out-Null
