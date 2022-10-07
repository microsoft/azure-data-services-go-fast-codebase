#param(
#    [Parameter()]
#    [string]
#    $test = "#########"   
#)

#!!!!Run as Admin !!!

$LocalDrive = "C:"                                                                                       #Drive where the below directory will be created.
$LocalDownloadFolder = "DBInstallDir"    
$LogFile = ($LocalDrive  + '\' +  $LocalDownloadFolder + '\' + 'Log.txt')
New-Item -Path ($LocalDrive  + '\') -Name $LocalDownloadFolder -ItemType Directory -Force
Set-Location -Path ($LocalDrive  + '\' +  $LocalDownloadFolder + '\')

function WriteLog
{
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $LogMessage = "$Stamp $LogString"
    Add-content $LogFile -value $LogMessage
}

WriteLog "Starting..."
WriteLog $Env:PSModulePath
WriteLog $env:UserName
$ProgressPreference = 'SilentlyContinue'    #Turn-off the progress bar and speed up the download via Invoke-WebRequest


if($null -eq (Get-PSRepository | Where-Object {$_.Name -eq "PSGallery"}))
{
    Write-Output "Registering Nuget"
	$res = Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force            
	Register-PSRepository -Default -InstallationPolicy Trusted
    
}
else 
{
    Write-Output "Re-Registering PSGallery"
    $res = Unregister-PSRepository -Name "PSGallery"
    $res = Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force            
	Register-PSRepository -Default -InstallationPolicy Trusted
   
}

$SqlInstalled =  (get-module -ListAvailable | Where-object {$_.Name -eq 'SqlServer'})

#if($null -eq $SqlInstalled)

WriteLog "Uninstalling SQLPS"
Remove-Module SQLPS 
rm "C:\Program Files (x86)\Microsoft SQL Server\150\Tools\PowerShell\Modules" -r
try {
    UnInstall-Module -Name SQLPS -Force
}
catch {
    WriteLog $Error
} 
WriteLog "Installing SqlServer Module"
try {
    Install-Module -Name SqlServer -Force -AllowClobber -RequiredVersion 21.1.18256

}
catch {
    WriteLog $Error
} 
    

Import-Module -Name SqlServer -Force -MinimumVersion 21.1.18256

$SqlInstalled =  (Get-Module -ListAvailable | Where-object {$_.Name -like 'SqlS'})
WriteLog ($SqlInstalled | ConvertTo-Json)
WriteLog $SqlInstalled.Name
WriteLog $SqlInstalled.Version
#Register-PackageSource -Name Nuget -Location "http://www.nuget.org/api/v2" –ProviderName Nuget -Trusted
#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force


WriteLog "Starting AWs Download"
$DownloadURL = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2019.bak"
$LocalFileName = $DownloadURL.Split("/")[$DownloadURL.Split("/").Length-1]                   #Get the filename.
$InstallerLocalFileLocation = $LocalDrive + '\' + $LocalDownloadFolder + '\' + $LocalFileName     #Local Path of downloaded installer.

Invoke-WebRequest -Uri $DownloadURL -OutFile $InstallerLocalFileLocation  

WriteLog "Starting DB Restore"
$RelocateData = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorksLT2012_Data", "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksLT2012_Data.mdf")
$RelocateLog = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorksLT2012_Log", "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksLT2012_Log.ldf")

try
{
    sqlcmd -Q "CREATE USER [NT AUTHORITY\SYSTEM];"
    sqlcmd -Q "EXEC master..sp_addsrvrolemember @loginame = N'NT AUTHORITY\SYSTEM', @rolename = N'sysadmin'";
    Restore-SqlDatabase -ServerInstance "localhost" -Database "Adventureworks" -BackupFile "C:\DBInstallDir\AdventureWorksLT2019.bak" -RelocateFile @($RelocateData,$RelocateLog)  
}
catch
{
    WriteLog $Error
}

WriteLog "Starting Sql Server Agent"
Set-Service sqlserveragent -StartUpType "Automatic"
Start-Service sqlserveragent

WriteLog "Enabling CDC"
sqlcmd -Q "EXEC sp_changedbowner 'sa'" -d "Adventureworks"
sqlcmd -Q "EXEC sys.sp_cdc_enable_db" -d "Adventureworks"
sqlcmd -Q "EXEC sys.sp_cdc_enable_table @source_schema = N'SalesLT',  @source_name   = N'Product',  @role_name     = NULL,  @supports_net_changes = 1" -d "Adventureworks"
sqlcmd -Q "EXEC sys.sp_cdc_enable_table @source_schema = N'SalesLT',  @source_name   = N'Customer',  @role_name     = NULL,  @supports_net_changes = 1" -d "Adventureworks"
sqlcmd -Q "EXEC sys.sp_cdc_enable_table @source_schema = N'SalesLT',  @source_name   = N'SalesOrderHeader',  @role_name     = NULL,  @supports_net_changes = 1" -d "Adventureworks"  