remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    # You need to update the resource group and storage account here. 
    # You should have created these with the Prepare.ps1 script.
    resource_group_name  = "con-stg-rg-ads"
    storage_account_name = "constgstadsstate"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
  }

# These inputs are provided to the terraform variables when deploying the environment
# If you are deploying using pipelines, these can be overridden from environment variables
# using TF_VAR_variablename
inputs = {
  prefix                                = "con"            # All azure resources will be prefixed with this
  domain                                = "contoso.com"    # Used when configuring AAD config for Azure functions 
  tenant_id                             = ""               # This is the Azure AD tenant ID
  subscription_id                       = ""               # The azure subscription id to deploy to
  resource_location                     = "Australia East" # The location of the resources
  resource_group_name                   = "con-stg-rg-ads" # The resource group all resources will be deployed to
  owner_tag                             = "Contoso"        # Owner tag value for Azure resources
  environment_tag                       = "stg"            # This is used on Azure tags as well as all resource names
  ip_address                            = ""               # This is the ip address of the agent/current IP. Used to create firewall exemptions.
  deploy_sentinel                       = true
  deploy_purview                        = false      
  deploy_synapse                        = true  
} 