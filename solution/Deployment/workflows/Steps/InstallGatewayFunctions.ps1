#### Here is the usage doc:
#### PS D:\GitHub> .\InstallGatewayOnLocalMachine.ps1 E:\shared\bugbash\IntegrationRuntime.msi <key>
####

param([string]$path, [string]$authKey)
function Install-Gateway([string] $gwPath)
{
    # uninstall any existing gateway
    UnInstall-Gateway

    Write-Debug " Start Gateway installation"
    
    Start-Process "msiexec.exe" "/i $path /quiet /passive" -Wait
    Start-Sleep -Seconds 30	

    Write-Debug " Succeed to install gateway"
}

function Register-Gateway([string] $key)
{
    Write-Debug " Start to register gateway with key: $key"
    $cmd = Get-CmdFilePath
    Start-Process $cmd "-k $key" -Wait
    Write-Debug " Succeed to register gateway"

}

function Check-WhetherGatewayInstalled([string]$name)
{
    $installedSoftwares = Get-ChildItem "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    foreach ($installedSoftware in $installedSoftwares)
    {
        $displayName = $installedSoftware.GetValue("DisplayName")
        if($DisplayName -eq "$name Preview" -or  $DisplayName -eq "$name")
        {
            return $true
        }
    }

    return $false
}


function UnInstall-Gateway()
{
    $installed = $false
    if (Check-WhetherGatewayInstalled("Microsoft Integration Runtime"))
    {
        [void](Get-WmiObject -Class Win32_Product -Filter "Name='Microsoft Integration Runtime Preview' or Name='Microsoft Integration Runtime'" -ComputerName $env:COMPUTERNAME).Uninstall()
        $installed = $true
    }

    if (Check-WhetherGatewayInstalled("Microsoft Integration Runtime"))
    {
        [void](Get-WmiObject -Class Win32_Product -Filter "Name='Microsoft Integration Runtime Preview' or Name='Microsoft Integration Runtime'" -ComputerName $env:COMPUTERNAME).Uninstall()
        $installed = $true
    }

    if ($installed -eq $false)
    {
        Write-Debug " Microsoft Integration Runtime Preview is not installed."
        return
    }

    Write-Debug " Microsoft Integration Runtime has been uninstalled from this machine."
}

function Get-CmdFilePath()
{
    $filePath = Get-ItemPropertyValue "hklm:\Software\Microsoft\DataTransfer\DataManagementGateway\ConfigurationManager" "DiacmdPath"
    if ([string]::IsNullOrEmpty($filePath))
    {
        throw "Get-InstalledFilePath: Cannot find installed File Path"
    }

    return $filePath
}

function Validate-Input([string]$path, [string]$key)
{
    if ([string]::IsNullOrEmpty($path))
    {
        throw "Gateway path is not specified"
    }

    if (!(Test-Path -Path $path))
    {
        throw "Invalid gateway path: $path"
    }

    if ([string]::IsNullOrEmpty($key))
    {
        throw "Gateway Auth key is empty"
    }
}

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

Validate-Input $path $authKey

Install-Gateway $path
Register-Gateway $authKey