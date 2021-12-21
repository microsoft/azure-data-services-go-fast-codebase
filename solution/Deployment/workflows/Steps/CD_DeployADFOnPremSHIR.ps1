
$ProgressPreference = 'SilentlyContinue'                                                                    #Turn-off the progress bar and speed up the download via Invoke-WebRequest

$ADFLocalDrive = $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_IrInstallConfig_LocalDrive #"C:"                                                                                       #Drive where the below directory will be created.
$ADFLocalVMFolder = $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_IrInstallConfig_LocalVMFolder #"ADFInstaller"                                                                          #Directory in which the .msi files will be downloaded.

$ADFIRDownloadURL = $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_IrInstallConfig_IrDownloadURL #"https://download.microsoft.com/download/E/4/7/E4771905-1079-445B-8BF9-8A1A075D8A10/IntegrationRuntime_5.9.7900.1.msi"
$ADFIRLocalFileName = $ADFIRDownloadURL.Split("/")[$ADFIRDownloadURL.Split("/").Length-1]                   #Get the .msi filename.
$ADFIRInstallerLocalFileLocation = $ADFLocalDrive + '\' + $ADFLocalVMFolder + '\' + $ADFIRLocalFileName     #Local Path of downloaded installer.

$ADFJDKDownloadURL = $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_IrInstallConfig_JDKDownloadURL #"https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_windows_hotspot_11.0.12_7.msi"
$ADFJDKLocalFileName = $ADFJDKDownloadURL.Split("/")[$ADFJDKDownloadURL.Split("/").Length-1]                #Get the .msi filename.
$ADFJDKInstallerLocalFileLocation = $ADFLocalDrive + '\' +  $ADFLocalVMFolder + '\' + $ADFJDKLocalFileName  #Local Path of downloaded installer.

Write-Debug " Creating directory to download the SHIR installable."
New-Item -Path $ADFLocalDrive -Name $ADFLocalVMFolder -ItemType Directory -Force                            #'-Force' Ok if directory already exists.

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
    # 'INSTALLDIR="c:\Program Files\Eclipse Foundation\"'
    'INSTALLDIR="""$env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_IrInstallConfig_JDKInstallFolder"""'
    "/qb!"
    "/norestart" 
)
Write-Debug $MSIInstallArguments
Start-Process "msiexec.exe" -ArgumentList $MSIInstallArguments  -Wait -NoNewWindow

Write-Debug " Installing SHIR."
# Data Factory - VM AZ IR - Install IR
# $irKey1 = az datafactory integration-runtime list-auth-key --factory-name $DataFactoryName --name "SelfHostedIntegrationRuntime-Azure-VNET" --resource-group $ResourceGroupName --query authKey1 --out tsv
# az vm run-command invoke  --command-id RunPowerShellScript --name $VMAzIR -g $ResourceGroupName --scripts "$ADFIRInstallerLocalFileLocation -path $ADFIRLocalFileLocation -authKey '$irKey1'"
# 

$irKey1 = az datafactory integration-runtime list-auth-key --factory-name $env:AdsOpts_CD_Services_DataFactory_Name --name $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query authKey1 --out tsv
Write-Debug " irKey1 retrieved."

# #Ensure command prompt is run as administrator
# $MSIInstallArguments = @(
#     "/i"
#     "$ADFIRInstallerLocalFileLocation"
#     "authKey='$irKey1'"
#     "/qb!"
#     "/norestart" 
# )
# Write-Debug $MSIInstallArguments
# Start-Process "msiexec.exe" -ArgumentList $MSIInstallArguments  -Wait -NoNewWindow

. .\Steps\InstallGatewayFunctions.ps1 -path "$ADFIRInstallerLocalFileLocation" -authKey "$irKey1"