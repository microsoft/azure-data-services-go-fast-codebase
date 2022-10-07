locals {
  common_vars = jsondecode(file("../../../bin/environments/uat/common_vars_for_hcl.json"))
}


generate "layer1.tf" {
  path      = "layer1.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    data "terraform_remote_state" "layer1" {
      # The settings here should match the "backend" settings in the
      # configuration that manages the network resources.
      backend = "azurerm"
      
      config = {
        container_name       = "tstate"
        key                  = "terraform_layer1.tfstate"
        resource_group_name  = "${local.common_vars.resource_group_name}"
        storage_account_name = "${local.common_vars.state_storage_account_name}"
      }
    }
  EOF
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    # You need to update the resource group and storage account here. 
    # You should have created these with the Prepare.ps1 script.
    resource_group_name  = "${local.common_vars.resource_group_name}"
    storage_account_name = "${local.common_vars.state_storage_account_name}"
    container_name       = "tstate"
    key                  = "terraform_layer2.tfstate"
  }
}

# These inputs are provided to the terraform variables when deploying the environment
# If you are deploying using pipelines, these can be overridden from environment variables
# using TF_VAR_variablename
inputs = {
  prefix                                = "${local.common_vars.prefix}"                                  # All azure resources will be prefixed with this
  domain                                = "${local.common_vars.domain}"                        # Used when configuring AAD config for Azure functions 
  tenant_id                             = "${local.common_vars.tenant_id}"                   # This is the Azure AD tenant ID
  subscription_id                       = "${local.common_vars.subscription_id}" # The azure subscription id to deploy to
  resource_location                     = "${local.common_vars.resource_location}"                       # The location of the resources
  resource_group_name                   = "${local.common_vars.resource_group_name}"         # The resource group all resources will be deployed to
  owner_tag                             = "${local.common_vars.owner_tag}"                              # Owner tag value for Azure resources
  environment_tag                       = "${local.common_vars.environment_tag}"                                  # This is used on Azure tags as well as all resource names
  ip_address                            = "${local.common_vars.ip_address}"                      # This is the ip address of the agent/current IP. Used to create firewall exemptions.
  azure_sql_aad_administrators          = "${local.common_vars.azure_sql_aad_administrators}"
  azure_purview_data_curators          = "${local.common_vars.azure_purview_data_curators}"                                                         
  synapse_administrators                = "${local.common_vars.synapse_administrators}"  
  resource_owners                       = "${local.common_vars.resource_owners}"    
  deploy_web_app                        = true
  deploy_function_app                   = true
  deploy_custom_terraform               = false # This is whether the infrastructure located in the terraform_custom folder is deployed or not.
  deploy_app_service_plan               = true
  deploy_data_factory                   = true
  deploy_sentinel                       = true
  deploy_purview                        = false
  deploy_synapse                        = true
  deploy_metadata_database              = true
  is_vnet_isolated                      = false
  publish_web_app                       = true
  publish_function_app                  = true
  publish_sample_files                  = true
  publish_metadata_database             = true
  configure_networking                  = false
  publish_datafactory_pipelines         = true
  publish_web_app_addcurrentuserasadmin = true
  deploy_selfhostedsql                  = false
  is_onprem_datafactory_ir_registered   = false
  publish_sif_database                  = true
  deployment_principal_layers1and3      = "${local.common_vars.deployment_principal_layers1and3}"
}
