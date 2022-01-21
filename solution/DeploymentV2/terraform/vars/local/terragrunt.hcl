inputs = {
  prefix                                = "con"            # All azure resources will be prefixed with this
  domain                                = "contoso.com"    # Used when configuring AAD config for Azure functions 
  tenant_id                             = ""               # This is the Azure AD tenant ID
  subscription_id                       = ""               # The azure subscription id to deploy to
  resource_location                     = "Australia East" # The location of the resources
  resource_group_name                   = "con-dev-rg-ads" # The resource group all resources will be deployed to
  owner_tag                             = "Contoso"        # Owner tag value for Azure resources
  environment_tag                       = "dev"            # This is used on Azure tags as well as all resource names
  ip_address                            = ""               # This is the ip address of the agent/current IP. Used to create firewall exemptions.
  deploy_sentinel                       = false
  deploy_purview                        = false      
  deploy_synapse                        = false  
  is_vnet_isolated                      = false
} 
