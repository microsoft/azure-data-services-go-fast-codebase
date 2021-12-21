#Function for password generator
$symbols = '!@#$%^&*'.ToCharArray()
$characterList = 'a'..'z' + 'A'..'Z' + '0'..'9' + $symbols
function GeneratePassword {
    param(
        [ValidateRange(12, 256)]
        [int] 
        $length = 14
    )

    do {
        $password = -join (0..$length | % { $characterList | Get-Random })
        [int]$hasLowerChar = $password -cmatch '[a-z]'
        [int]$hasUpperChar = $password -cmatch '[A-Z]'
        [int]$hasDigit = $password -match '[0-9]'
        [int]$hasSymbol = $password.IndexOfAny($symbols) -ne -1

    }
    until (($hasLowerChar + $hasUpperChar + $hasDigit + $hasSymbol) -ge 3)

    $password | ConvertTo-SecureString -AsPlainText
}


Write-Debug "Configuring Azure SQL Server"

#Install Sql Server Module
if (Get-Module -ListAvailable -Name SqlServer) {
    Write-Host "SqlServer Module exists"
} 
else {
    Write-Host "Module does not exist.. installing.."
    Install-Module -Name SqlServer -Force
}

#Get Access Token for SQL --Note that the deployment principal or user running locally will need rights on the database
$token=$(az account get-access-token --resource=https://database.windows.net/ --query accessToken --output tsv)     


$targetserver = $env:AdsOpts_CD_Services_AzureSQLServer_Name + ".database.windows.net"
if($env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Enable -eq "True")
{

    #Add Ip to SQL Firewall
    $myIp = (Invoke-WebRequest ifconfig.me/ip).Content
    $result = az sql server firewall-rule create -g $env:AdsOpts_CD_ResourceGroup_Name -s $env:AdsOpts_CD_Services_AzureSQLServer_Name -n "MySetupIP" --start-ip-address $myIp --end-ip-address $myIp
    #Allow Azure services and resources to access this server
    $result = az sql server firewall-rule create -g $env:AdsOpts_CD_ResourceGroup_Name -s $env:AdsOpts_CD_Services_AzureSQLServer_Name -n "Azure" --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

    $CurrentPath = (Get-Location).Path
    Set-Location "..\bin\publish\unzipped\database\"

    #Create User for DBUp
    $temppassword = GeneratePassword
    $sql = "
            DROP USER IF EXISTS DbUpUser
            CREATE USER DbUpUser WITH PASSWORD=N'$temppassword', DEFAULT_SCHEMA=[dbo]
            EXEC sp_addrolemember 'db_owner', 'DbUpUser'
            GO "

    Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query $sql

    #.\AdsGoFastDbUp.exe -c "Server=$targetserver; Database=$env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name; user id=$env:AdsOpts_CD_Services_AzureSQLServer_AdminUser; password=$env:AdsOpts_CD_Services_AzureSQLServer_AdminPassword" -v True
    dotnet AdsGoFastDbUp.dll -c "Server=$targetserver; Database=$env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name; user id=DbUpUser; password='$temppassword'" -v True 
    Set-Location $CurrentPath
    

    #Environment Specific Updates 
    $subid = (az account show -s $env:AdsOpts_CD_ResourceGroup_Subscription | ConvertFrom-Json).id
    $LogAnalyticsId = az monitor log-analytics workspace show --resource-group $env:AdsOpts_CD_ResourceGroup_Name --workspace-name $env:AdsOpts_CD_Services_LogAnalytics_Name --query customerId --out tsv 
    
    if($env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_UpdateDataFactory -eq "True")
    {
        $sql = 
        "Update [dbo].[DataFactory]
            Set [Name] = '$env:AdsOpts_CD_Services_DataFactory_Name', 
            ResourceGroup = '$env:AdsOpts_CD_ResourceGroup_Name',
            SubscriptionUid = '$subid',
            DefaultKeyVaultURL = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/', 
            LogAnalyticsWorkspaceId = '$LogAnalyticsId'
        where id = 1"

        Write-Debug "Updating DataFactory in ADS Go Fast DB Config - DataFactory"
        Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query $sql
    }
    if($env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_UpdateSourceAndTargetSystems -eq "True")
    {
        $sql = 
        "
        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = '$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Database"" : ""$env:AdsOpts_CD_Services_AzureSQLServer_SampleDB_Name"" }'
        Where 
            SystemId = '1'
        GO

        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = '$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Database"" : ""$env:AdsOpts_CD_Services_AzureSQLServer_StagingDB_Name"" }'
        Where 
            SystemId = '2'
        GO

        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = '$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Database"" : ""$env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name"" }'
        Where 
            SystemId = '11'
        GO
        "

        Write-Debug "Updating DataFactory in ADS Go Fast DB Config - SourceAndTargetSystems - Azure SQL Servers"
        Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query $sql

        $sql = 
        "
        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = 'https://$env:AdsOpts_CD_Services_Storage_Blob_Name.blob.core.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Container"" : ""datalakeraw"" }'
        Where 
            SystemId = '3'
        GO

        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = 'https://$env:AdsOpts_CD_Services_Storage_Blob_Name.blob.core.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Container"" : ""datalakelanding"" }'
        Where 
            SystemId = '7'
        GO

        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = 'https://$env:AdsOpts_CD_Services_Storage_Blob_Name.blob.core.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Container"" : ""transientin"" }'
        Where 
            SystemId = '9'
        GO

        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
            SystemServer = 'https://$env:AdsOpts_CD_Services_Storage_ADLS_Name.dfs.core.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Container"" : ""datalakeraw"" }'
        Where 
            SystemId = '4'
        GO

        Update 
        [dbo].[SourceAndTargetSystems]
        Set 
        SystemServer = 'https://$env:AdsOpts_CD_Services_Storage_ADLS_Name.dfs.core.windows.net',
            SystemKeyVaultBaseUrl = 'https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/',
            SystemJSON = '{ ""Container"" : ""datalakelanding"" }'
        Where 
            SystemId = '8'
        GO
        "

        Write-Debug "Updating DataFactory in ADS Go Fast DB Config - SourceAndTargetSystems - Storage Accounts"
        Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query $sql

    }
    
    #sqlpackage.exe /a:Publish /sf:'./../bin/publish/unzipped/database/AdsGoFastBuild.dacpac' /tsn:$targetserver  /tdn:$env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name /tu:$env:AdsOpts_CD_Services_AzureSQLServer_AdminUser /tp:$env:AdsOpts_CD_Services_AzureSQLServer_AdminPassword

    
    #Database - Post Script Deployment
    #Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -Username $env:AdsOpts_CD_Services_AzureSQLServer_AdminUser -Password $env:AdsOpts_CD_Services_AzureSQLServer_AdminPassword -InputFile "./../../Database/AdsGoFastDatabase"  

}
else 
{
    Write-Warning "Skipped Configuring Azure SQL Server"
}