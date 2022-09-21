$Environments = @("Local","Staging")

foreach ($e in $Environments)
{
    Write-Host $e
    $environmentFile = "./EnvironmentTemplate_" + $e + ".hcl"
    $environmentFileContents = Get-Content $environmentFile
    
    $environmentFileTarget = "./terraform/vars/" + $e.ToLower() + "/terragrunt.hcl"
    
    $environmentFileContents = $environmentFileContents.Replace("{prefix}","ads")
    $environmentFileContents = $environmentFileContents.Replace("{resource_group_name}","AdsGoFastDemo")
    $environmentFileContents = $environmentFileContents.Replace("{storage_account_name}","TerraformStateAccount")
    $environmentFileContents = $environmentFileContents.Replace("{subscription_id}","c5743ec2-31b2-4596-baaf-779cd189bb94")
    $environmentFileContents = $environmentFileContents.Replace("{tenant_id}","63a6ed72-a904-4f18-95dd-3b4c9ffdd1d1")
    $environmentFileContents = $environmentFileContents.Replace("{ip_address}","192.168.0.1")
    $environmentFileContents = $environmentFileContents.Replace("{domain}","contoso.com")

    #------------------------------------------------------------------------------------------------------------
    # Templated Configurations
    #------------------------------------------------------------------------------------------------------------

    $environmentFileContents = $environmentFileContents.Replace("{deploy_sentinel}","true")
    $environmentFileContents = $environmentFileContents.Replace("{deploy_purview}","true")
    $environmentFileContents = $environmentFileContents.Replace("{deploy_synapse}","true")
    $environmentFileContents = $environmentFileContents.Replace("{is_vnet_isolated}","true")
    $environmentFileContents = $environmentFileContents.Replace("{publish_web_app}","true")
    $environmentFileContents = $environmentFileContents.Replace("{publish_function_app}","true")
    $environmentFileContents = $environmentFileContents.Replace("{publish_sample_files}","true")
    $environmentFileContents = $environmentFileContents.Replace("{publish_metadata_database}","true")
    $environmentFileContents = $environmentFileContents.Replace("{configure_networking}","true")
    $environmentFileContents = $environmentFileContents.Replace("{publish_datafactory_pipelines}","true")
    $environmentFileContents = $environmentFileContents.Replace("{publish_web_app_addcurrentuserasadmin}","true")
    $environmentFileContents = $environmentFileContents.Replace("{deploy_selfhostedsql}","false")
    $environmentFileContents = $environmentFileContents.Replace("{is_onprem_datafactory_ir_registered}","false")

    
    $environmentFileContents | Set-Content $environmentFileTarget
}