param(
    [Parameter()]
    [string]
    $authkey = "#########"   
)

<# ###############################################################################################

    Functions 

 
 ############################################################################################## #>


#### Here is the usage doc:
#### PS D:\GitHub> .\InstallGatewayOnLocalMachine.ps1 E:\shared\bugbash\IntegrationRuntime.msi <key>
####

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



function CheckIsAdmin()
{
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
        Break
    }
}

$ProgressPreference = 'SilentlyContinue'                                                                    #Turn-off the progress bar and speed up the download via Invoke-WebRequest

$ADFLocalDrive = "C:"                                                                                       #Drive where the below directory will be created.
$ADFLocalVMFolder = "ADFInstaller"                                                                          #Directory in which the .msi files will be downloaded.

$ADFIRDownloadURL = "https://download.microsoft.com/download/E/4/7/E4771905-1079-445B-8BF9-8A1A075D8A10/IntegrationRuntime_5.9.7900.1.msi"
$ADFIRLocalFileName = $ADFIRDownloadURL.Split("/")[$ADFIRDownloadURL.Split("/").Length-1]                   #Get the .msi filename.
$ADFIRInstallerLocalFileLocation = $ADFLocalDrive + '\' + $ADFLocalVMFolder + '\' + $ADFIRLocalFileName     #Local Path of downloaded installer.

$ADFJDKDownloadURL = "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_windows_hotspot_11.0.12_7.msi"
$ADFJDKLocalFileName = $ADFJDKDownloadURL.Split("/")[$ADFJDKDownloadURL.Split("/").Length-1]                #Get the .msi filename.
$ADFJDKInstallerLocalFileLocation = $ADFLocalDrive + '\' +  $ADFLocalVMFolder + '\' + $ADFJDKLocalFileName  #Local Path of downloaded installer.

Write-Debug " Creating directory to download the SHIR installable."
New-Item -Path ($ADFLocalDrive + '\' + $ADFLocalVMFolder) -Name $ADFLocalVMFolder -ItemType Directory -Force                            #'-Force' Ok if directory already exists.

Write-Debug " Downloading the SHIR installable at $ADFIRInstallerLocalFileLocation."
Invoke-WebRequest -Uri $ADFIRDownloadURL -OutFile $ADFIRInstallerLocalFileLocation                          #Download SHIR installable.

Write-Debug " Downloading the OpenJDK for SHIR at $ADFJDKInstallerLocalFileLocation."
Invoke-WebRequest -Uri $ADFJDKDownloadURL -OutFile $ADFJDKInstallerLocalFileLocation                        #Download OpenJDK.

Write-Debug " Installing OpenJDK."
#msiexec /i $ADFJDKInstallerLocalFileLocation ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome /quiet

#Ensure command prompt is run as administrator
$MSIInstallArguments = @(
    "/i"
    "$ADFJDKInstallerLocalFileLocation"
    'ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome'
    'INSTALLDIR="c:\Program Files\Eclipse Foundation\"'
    #'INSTALLDIR="""$env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_IrInstallConfig_JDKInstallFolder"""'
    "/qb!"
    "/norestart" 
)
Start-Process "msiexec.exe" -ArgumentList $MSIInstallArguments  -Wait -NoNewWindow

Write-Debug " Installing SHIR."
# Data Factory - VM AZ IR - Install IR
# $irKey1 = az datafactory integration-runtime list-auth-key --factory-name $DataFactoryName --name "SelfHostedIntegrationRuntime-Azure-VNET" --resource-group $ResourceGroupName --query authKey1 --out tsv
# az vm run-command invoke  --command-id RunPowerShellScript --name $VMAzIR -g $ResourceGroupName --scripts "$ADFIRInstallerLocalFileLocation -path $ADFIRLocalFileLocation -authKey '$irKey1'"
# 

# #Ensure command prompt is run as administrator
$MSIInstallArguments = @(
     "/i"
     "$ADFIRInstallerLocalFileLocation"
     "authKey='$authkey'"
     "/qb!"
     "/norestart" 
 )
 #Write-Debug $MSIInstallArguments
 Start-Process "msiexec.exe" -ArgumentList $MSIInstallArguments  -Wait -NoNewWindow

#CheckIsAdmin
#Validate-Input $ADFIRInstallerLocalFileLocation $authKey
#Install-Gateway $ADFIRInstallerLocalFileLocation
Register-Gateway $authkey
