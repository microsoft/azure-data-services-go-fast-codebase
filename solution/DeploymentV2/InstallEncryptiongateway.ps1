#----------------------------------------------------------------------------------------------------------------
# Installation of IXUP Encryption Gateway 
#----------------------------------------------------------------------------------------------------------------
param(
    [Parameter()]
    [string]
    $arg0 = "#########"   
)

Set-PSDebug -Trace 1
mkdir "C:\ixup"
Set-Location "C:\ixup"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile("https://ixup-artifacts.s3.ap-southeast-2.amazonaws.com/egw/IXUPAgent.msi", "C:\ixup\IXUPAgent.msi")
Start-Process -Wait -FilePath C:\ixup\IXUPAgent.msi -ArgumentList "/quiet"

#----------------------------------------------------------------------------------------------------------------
# Install Chrome
#----------------------------------------------------------------------------------------------------------------
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path$Installer;
Start-Process -FilePath $Path$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path$Installer

#----------------------------------------------------------------------------------------------------------------
# Create ShortCut on Desktop for IXUP Application
#----------------------------------------------------------------------------------------------------------------
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\adminuser\Desktop\IxupApp.lnk")
$ShortCut.TargetPath="C:\Program Files\Google\Chrome\Application\chrome.exe"
$Shortcut.Arguments = "$arg0"
$Shortcut.Save()
