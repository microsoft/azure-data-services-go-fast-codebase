######################################################
### Continuous Deployment                         ####
######################################################Write-Host ([Environment]::GetEnvironmentVariable("AdsOpts_CI_Enable"))
if (([Environment]::GetEnvironmentVariable("AdsOpts_CD_EnableDeploy")) -eq "True")
{
    $Scripts = @(
                    ".\Steps\CD_DeployKeyVault.ps1"
                    ,".\Steps\CD_DeployStorageForLogging.ps1"
                    ,".\Steps\CD_DeployStorageADLS.ps1"
                    ,".\Steps\CD_DeployStorageBlob.ps1"                    
    )
    
    Write-Debug "Starting CD.."

    $Scripts|ForEach-Object -Parallel {
        Invoke-Expression -Command $_
    }

    $Scripts = @(
                    ,".\Steps\CD_DeployAppInsights.ps1"
                    ,".\Steps\CD_DeployLogAnalytics.ps1"
                    ,".\Steps\CD_DeployVnet.ps1"       
    )

    $Scripts|ForEach-Object -Parallel {
        Invoke-Expression -Command $_
    }

    $Scripts = @(
                    ,".\Steps\CD_DeployAppService.ps1"
                    ,".\Steps\CD_DeployAzureSqlServer.ps1"
                    ,".\Steps\CD_DeployADF.ps1"
    )

    $Scripts|ForEach-Object -Parallel {
        Invoke-Expression -Command $_
    }

    $Scripts = @(
                    ,".\Steps\CD_DeployWebSite.ps1"
                    ,".\Steps\CD_DeployFunctionApp.ps1"
    )

    $Scripts|ForEach-Object -Parallel {
        Invoke-Expression -Command $_
    }

    Write-Debug "Finishing CD.."
}
else 
{

    Write-Warning "CD_1a_DeployServices.ps1 skipped as flag in environment file is set to false" 
}

 #,".\Cleanup_RemoveAll.ps1"