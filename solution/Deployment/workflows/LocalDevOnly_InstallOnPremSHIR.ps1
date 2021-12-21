if (([Environment]::GetEnvironmentVariable("AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Enable")) -eq "True")
{
    Write-Host "Starting On Prem SHIR Installation.."

    Invoke-Expression -Command  ".\Steps\CD_DeployADFOnPremSHIR.ps1"

    Write-Host "Completed On Prem SHIR Installation."
}
