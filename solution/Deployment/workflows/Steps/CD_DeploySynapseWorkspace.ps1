#TO DO:
#1.Deploy Synapse ARM (Workspace, Storage, Dedicated Pool, Spark Pool) (ARM + PS) - DONE [CD_DeploySynapseWorkspace.ps1]
#2.To allow secured storage a/c acces from workspace, under storage a/c networking, allow Synapse Workspace under Resource instances (MANUAL from Portal) - PENDING as az cli support is not yet available
#   a. workspace's storage a/c
#   b. Any other secured storage a/c e.g. adls 
#3.Create a Synapse Managed PE to:  (az cli + PS) - DONE [CD_ConfigureSynapseWorkspace.ps1]
#   a. ADS GF adls gen2 storage account
#4. Grant workspace service managed identity access to your Azure Data Lake Storage Gen2. - DONE [CD_ConfigureSynapseWorkspace.ps1]
#   a. ADS GF adls gen2 storage account

#Synapse Workspace 
if($env:AdsOpts_CD_Services_Synapse_Enable -eq "True")
{
    Write-Host "Creating Synapse Workspace (in a managed vNet) and related resources."
        
    az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/SynapseWorkspace.json --parameters `
    location=$env:AdsOpts_CD_ResourceGroup_Location `
    synapseName=$env:AdsOpts_CD_Services_Synapse_Name `
    synapseDlsName=$env:AdsOpts_CD_Services_Synapse_DlsName `
    synapseDlsFileSysName=$env:AdsOpts_CD_Services_Synapse_DlsFileSysName `
    synapseSqlPoolName=$env:AdsOpts_CD_Services_Synapse_SqlPoolName `
    synapseSparkPoolName=$env:AdsOpts_CD_Services_Synapse_SparkPoolName `
    synapseSparkPoolNodeCount=$env:AdsOpts_CD_Services_Synapse_SparkPoolNodeCount `
    synapseSparkPoolAutoScaleMinNodeCount=$env:AdsOpts_CD_Services_Synapse_SparkPoolAutoScaleMinNodeCount `
    synapseSparkPoolAutoScaleMaxNodeCount=$env:AdsOpts_CD_Services_Synapse_SparkPoolAutoScaleMaxNodeCount `
    sparkDeployment=$env:AdsOpts_CD_Services_Synapse_sparkDeployment `
    sparkNodeSize=$env:AdsOpts_CD_Services_Synapse_sparkNodeSize `
    dedicatedSqlPoolDeployment=$env:AdsOpts_CD_Services_Synapse_dedicatedSqlPoolDeployment `
    sqlAdministratorLogin=$env:AdsOpts_CD_Services_Synapse_sqlAdministratorLogin `
    sqlAdministratorLoginPassword=$env:AdsOpts_CD_Services_Synapse_sqlAdministratorLoginPassword `
    sku=$env:AdsOpts_CD_Services_Synapse_sku
}
else 
{
    Write-Host "Skipped Creation of Synapse Workspace (in a managed vNet) and related resources."
}