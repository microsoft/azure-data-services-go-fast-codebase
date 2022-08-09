#---------------------------------------------------------------
# Provider details
#---------------------------------------------------------------
variable "ip_address" {
  description = "The CICD ipaddress. We add an IP whitelisting to allow the setting of keyvault secrets"
  type        = string
}

variable "tenant_id" {
  description = "The AAD tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "resource_location" {
  description = "The Azure Region being deployed to."
  type        = string
  default     = "Australia East"
}

variable "resource_group_name" {
  type = string
}
#---------------------------------------------------------------
# Tags
#---------------------------------------------------------------

variable "owner_tag" {
  description = "The tags to apply to resources."
  type        = string
  default     = "opensource.microsoft.com"
}

variable "author_tag" {
  description = "The tags to apply to resources."
  type        = string
  default     = "opensource.microsoft.com"
}

variable "environment_tag" {
  description = "The name of the environment. Don't use spaces"
  default     = "dev"
  type        = string
}

#---------------------------------------------------------------
# Configuration 
#---------------------------------------------------------------
variable "domain" {
  description = "The AAD domain"
  type        = string
}
variable "cicd_sp_id" {
  description = "The Object Id of the GitHub Service Principal. This will ensure that keyvault access policies are configured for GitHub/terraform to read secret state later"
  type        = string
  default     = ""
}
//Onprem linked services and pipelines won't be registered until you complete the IR registration and set this to true
variable "is_onprem_datafactory_ir_registered" {
  description = "Are all on-premise Integration runtimes configured?"
  default     = false
  type        = bool
}

variable "is_vnet_isolated" {
  description = "Whether to deploy the resources as vnet attached / private linked"
  default     = true
  type        = bool
}

variable "sql_admin_username" {
  description = "The username for the sql server admin"
  default     = "adsgofastsqladminuser11"
  type        = string
}

variable "jumphost_password" {
  description = "Password for the jumphost"
  type        = string
}

variable "synapse_sql_login" {
  description = "Login for the Azure Synapse SQL admin"
  default     = "adsgofastsynapseadminuser14"
  type        = string
}

variable "synapse_sql_password" {
  description = "Password for the Azure Synapse SQL admin"
  type        = string
}

variable "allow_public_access_to_synapse_studio" {
  description = "Should the synapse studio allow access to public IPs"
  type        = bool
  default     = false
}

variable "vnet_cidr" {
  description = "CIDR of the vnet"
  type        = string
  default     = "10.0.0.0/24"
}
variable "plink_subnet_cidr" {
  description = "CIDR of the subnet used for private link endpoints"
  type        = string
  default     = "10.0.0.0/26"
}
variable "bastion_subnet_cidr" {
  description = "CIDR of the subnet used for bastion"
  type        = string
  default     = "10.0.0.64/26"
}
variable "app_service_subnet_cidr" {
  description = "CIDR of the subnet used to host the app service plan"
  type        = string
  default     = "10.0.0.128/26"
}

variable "vm_subnet_cidr" {
  description = "CIDR of the subnet used to host VM compute resources"
  type        = string
  default     = "10.0.0.192/26"
}

# This is used when deploying from outside the Vnet (running locally or with GitHub Hosted runners)
# When set to true. Resources will be created with public_access set to true and then a script
# will be executed at the end to set them back.
variable "delay_private_access" {
  description = "Whether to create resoruces with public access enabled and then disable it at the end."
  type        = bool
  default     = true
}


#---------------------------------------------------------------
# Feature Toggles
#---------------------------------------------------------------
variable "deploy_data_factory" {
  description = "Feature toggle for deploying the Azure Data Factory"
  default     = true
  type        = bool
}
variable "deploy_app_insights" {
  description = "Feature toggle for deploying the App Insights"
  default     = true
  type        = bool
}
variable "deploy_bastion" {
  description = "Feature toggle for deploying bastion"
  default     = true
  type        = bool
}
variable "deploy_app_service_plan" {
  description = "Feature toggle for deploying the App Service"
  default     = true
  type        = bool
}
variable "deploy_web_app" {
  description = "Feature toggle for deploying the Web App"
  default     = true
  type        = bool
}
variable "deploy_function_app" {
  description = "Feature toggle for deploying the Function App"
  default     = true
  type        = bool
}
variable "deploy_sql_server" {
  description = "Feature toggle for deploying the SQL Server"
  default     = true
  type        = bool
}

variable "deploy_metadata_database" {
  description = "Feature toggle for deploying Metadata Database"
  default     = true
  type        = bool
}

variable "deploy_sql_extend_audit_policy" {
  description = "Feature toggle for deploying the SQL Server Extended Audit policy"
  default     = true
  type        = bool
}
variable "deploy_azure_ad_web_app_registration" {
  description = "Feature toggle for deploying the Azure AD App registration for the Web Portal"
  default     = true
  type        = bool
}
variable "deploy_azure_ad_function_app_registration" {
  description = "Feature toggle for deploying the Azure AD App registration for the Function App"
  default     = true
  type        = bool
}
variable "deploy_azure_role_assignments" {
  description = "Feature toggle for deploying the Azure Role Assignments"
  default     = true
  type        = bool
}
variable "deploy_storage_account" {
  description = "Feature toggle for deploying the internal storage account"
  default     = true
  type        = bool
}
variable "deploy_adls" {
  description = "Feature toggle for deploying the internal data lake"
  default     = true
  type        = bool
}
variable "deploy_purview" {
  description = "Feature toggle for deploying Azure Purview"
  default     = false
  type        = bool
}
variable "deploy_sentinel" {
  description = "Feature toggle for deploying Azure Sentinel"
  default     = false
  type        = bool
}
variable "deploy_synapse" {
  description = "Feature toggle for deploying Azure Synapse"
  default     = false
  type        = bool
}

variable "deploy_synapse_sqlpool" {
  description = "Feature toggle for deploying Azure Synapse SQL Pool"
  default     = true
  type        = bool
}

variable "deploy_synapse_sparkpool" {
  description = "Feature toggle for deploying Azure Synapse Spark Pool"
  default     = true
  type        = bool
}

variable "deploy_selfhostedsql" {
  description = "Feature toggle for deploying Self Hosted Sql VM"
  default     = false
  type        = bool
}

variable "deploy_ixup_encryption_gw" {
  description = "Feature toggle for deploying IXUP Encrption Gateway"
  default     = false
  type        = bool
}

variable "deploy_h2o-ai" {
  description = "Feature toggle for deploying H2O-AI VM"
  default     = false
  type        = bool
}
variable "deploy_custom_vm" {
  description = "Feature toggle for deploying a custom virtual machine"
  default     = false
  type        = bool
}
variable "custom_vm_os" {
  description = "User must define whether they wish deploy a 'windows' or 'linux' virtual machine."
  default     = "linux"
  type        = string
}
variable "synapse_git_toggle_integration" {
  description = "Feature toggle for enabling synapse github integration"
  default     = false
  type        = bool
}
variable "synapse_git_integration_type" {
  description = "User must define whether they wish to use 'github' integration or 'devops'"
  default     = "github"
  type        = string
}

variable "synapse_git_use_pat" {
  description = "Whether a pat is required for authentication (non public repo)."
  default     = true
  type        = bool
}

variable "adf_git_toggle_integration" {
  description = "Feature toggle for enabling adf github integration"
  default     = false
  type        = bool
}

variable "adf_git_use_pat" {
  description = "Whether a pat is required for authentication (non public repo)."
  default     = true
  type        = bool
}
variable "deploy_custom_terraform" {
  description = "Whether the platform deploys the infrastructure located in the terraform_custom folder"
  default     = false
  type        = bool
}
#---------------------------------------------------------------
# Post IAC - Feature Toggles 
#---------------------------------------------------------------
variable "publish_web_app" {
  description = "Feature toggle for Publishing Web Application Code Base"
  default     = true
  type        = bool
}

variable "publish_function_app" {
  description = "Feature toggle for Publishing Function Application Code Base"
  default     = true
  type        = bool
}

variable "publish_sample_files" {
  description = "Feature toggle for Publishing Sample Filess"
  default     = true
  type        = bool
}

variable "publish_metadata_database" {
  description = "Feature toggle for Publishing Metadata Database schema and seeding with data"
  default     = true
  type        = bool
}
variable "publish_sql_logins" {
  description = "Feature toggle for Publishing Synapse / SQL database logins for lockbox"
  default     = true
  type        = bool
}
variable "publish_functional_tests" {
  description = "Feature toggle for Publishing Functional Tests to the Web App"
  default     = false
  type        = bool
}

variable "publish_purview_configuration" {
  description = "Feature toggle for deploying the Purview configuration script (WIP)"
  default     = false
  type        = bool
}
variable "configure_networking" {
  description = "Feature toggle for post IAC network configuration"
  default     = true
  type        = bool
}

variable "publish_datafactory_pipelines" {
  description = "Feature toggle for post IAC data factory pipeline deployment"
  default     = true
  type        = bool
}

variable "publish_web_app_addcurrentuserasadmin" {
  description = "Feature toggle for adding user running deployment as a webapp admin"
  default     = false
  type        = bool
}

variable "publish_sif_database" {
  description = "Feature toggle for Publishing SIF Database"
  default     = false
  type        = bool
}

variable "sif_database_name" {
  description = "SIF DataMart Name"
  default     = "sif"
  type        = string
}

#---------------------------------------------------------------
# Naming Prefix Settings
#---------------------------------------------------------------
variable "prefix" {
  description = "The prefix value to be used for autogenerated naming conventions"
  default     = "ark"
  type        = string
}
variable "app_name" {
  description = "The app_name suffix value to be used for autogenerated naming conventions"
  default     = "ads"
  type        = string
}

#---------------------------------------------------------------
# Override individual resource names
#---------------------------------------------------------------
variable "key_vault_name" {
  description = "The override name for the keyvault resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "app_service_plan_name" {
  description = "The override name for the app service plan resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "app_insights_name" {
  description = "The override name for the app insights resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "sql_server_name" {
  description = "The override name for the sql server resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "webapp_name" {
  description = "The override name for the web app service. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "functionapp_name" {
  description = "The override name for the function app service resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}

variable "aad_webapp_name" {
  description = "The override name for the AAD App registration for the web app. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "aad_functionapp_name" {
  description = "The override name for the AAD App registration for the function app. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "vnet_name" {
  description = "The override name for the Virtual Network resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "plink_subnet_name" {
  description = "The override name for the private link subnet resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "app_service_subnet_name" {
  description = "The override name for the app service subnet resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "vm_subnet_name" {
  description = "The override name for the vm subnet resource. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}

variable "app_service_nsg_name" {
  description = "The override name for the app service subnet NSG. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "plink_nsg_name" {
  description = "The override name for the private link subnet NSG. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "vm_nsg_name" {
  description = "The override name for the VM subnet NSG. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "bastion_nsg_name" {
  description = "The override name for the bastion subnet NSG. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "log_analytics_workspace_name" {
  description = "The override name for the Log Analytics workspace. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "logs_storage_account_name" {
  description = "The override name for the storage account used for logs. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "adls_storage_account_name" {
  description = "The override name for the storage account used for adls. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "blob_storage_account_name" {
  description = "The override name for the storage account used for staging data. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "bastion_name" {
  description = "The override name for the Bastion service. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "bastion_ip_name" {
  description = "The override name for the Bastion service Public IP. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "data_factory_name" {
  description = "The override name for the Data Factory component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "purview_name" {
  description = "The override name for the Purview component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "purview_ir_app_reg_name" {
  description = "The override name for the Purview Integration runtime SP. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "purview_resource_location" {
  description = "The override location for the Purview component. If empty, will be autogenerated based global location settings"
  default     = ""
  type        = string
}

variable "synapse_data_lake_name" {
  description = "The override name for the Synapse data lake component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "synapse_workspace_name" {
  description = "The override name for the Synapse workspace component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "synapse_dwpool_name" {
  description = "The override name for the Synapse Dedicated Pool component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "synapse_sppool_name" {
  description = "The override name for the Synapse spark pool component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}

variable "synapse_git_repository_owner" {
  description = "The owner of the github repository to be used for synapse. Eg. for the repository https://github.com/contoso/ads, the owner is contoso"
  default     = ""
  type        = string
}

variable "synapse_git_repository_name" {
  description = "The name of the github repository to be used for synapse"
  default     = ""
  type        = string
}
/*NOT CURRENLTY USED
variable "synapse_git_repository_base_url" {
  description = "The base URL of the git repository you are using for synapse E.g - https://github.com/microsoft/azure-data-services-go-fast-codebase / https://dev.azure.com/microsoft/_git/lockBoxProject"
  default = ""
  type = string
}*/
variable "synapse_git_repository_branch_name" {
  description = "The name of the github branch to be used"
  default     = "main"
  type        = string
}

variable "synapse_git_repository_root_folder" {
  description = "The name of the root folder to be used in the branch"
  default     = "/"
  type        = string
}
variable "synapse_git_github_host_url" {
  description = "Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com. Use https://github.com for open source repositories. Note: Not used for devops"
  default     = "https://github.com"
  type        = string
}
variable "synapse_git_devops_project_name" {
  description = "The name of the project to be referenced within devops. Note: Not used for github."
  default     = "/"
  type        = string
}

variable "synapse_git_devops_tenant_id" {
  description = "The tenant id of the devops project. By default it will be valued as your tenant_id. Note: Not used for github."
  default     = ""
  type        = string
}

variable "synapse_git_pat" {
  description = "The personal access token used to authenticate the git account"
  default     = ""
  type        = string
}
variable "synapse_git_user_name" {
  description = "The user name to be associated with the commit being done for the pipeline upload."
  default     = ""
  type        = string
}

variable "synapse_git_email_address" {
  description = "The email address to be associated with the commit being done for the pipeline upload."
  default     = ""
  type        = string
}
variable "adf_git_repository_owner" {
  description = "The owner of the github repository to be used for adf. Eg. for the repository https://github.com/contoso/ads, the owner is contoso"
  default     = ""
  type        = string
}

variable "adf_git_repository_name" {
  description = "The name of the github repository to be used for synapse"
  default     = ""
  type        = string
}
variable "adf_git_repository_branch_name" {
  description = "The name of the github branch to be used"
  default     = "main"
  type        = string
}

variable "adf_git_repository_root_folder" {
  description = "The name of the root folder to be used in the branch"
  default     = "/"
  type        = string
}

variable "adf_git_host_url" {
  description = "Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com. Use https://github.com for open source repositories."
  default     = "https://github.com"
  type        = string
}

variable "adf_git_pat" {
  description = "The personal access token used to authenticate the git account"
  default     = ""
  type        = string
}
variable "adf_git_user_name" {
  description = "The user name to be associated with the commit being done for the pipeline upload."
  default     = ""
  type        = string
}

variable "adf_git_email_address" {
  description = "The email address to be associated with the commit being done for the pipeline upload."
  default     = ""
  type        = string
}
#---------------------------------------------------------------
# Scale settings
#---------------------------------------------------------------
variable "app_service_sku" {
  description = "The sku/scale of the app service"
  type = object({
    tier = string
    size = string
  capacity = number })
  default = {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
}

variable "synapse_sku" {
  description = "The sku/scale of the Synapse SQL Pool"
  default     = "DW100c"
  type        = string
  validation {
    condition     = contains(["DW100c", "DW200c", "DW300c", "DW400c", "DW500c", "DW1000c", "DW1500c", "DW2000c", "DW2500c", "DW3000c"], var.synapse_sku)
    error_message = "Invalid values for var: synapse_sku."
  }
}


variable "synapse_spark_min_node_count" {
  description = "The minimum number of spark nodes in the autoscale pool"
  default     = 3
  type        = number
}

variable "synapse_spark_max_node_count" {
  description = "The maximum number of spark nodes in the autoscale pool"
  default     = 12
  type        = number
}




#---------------------------------------------------------------
# Parameters for specifying existing resources for reuse/
#---------------------------------------------------------------
variable "existing_log_analytics_workspace_id" {
  description = "An existing log analytics workspace id for reuse"
  default     = ""
  type        = string
}
variable "existing_log_analytics_resource_id" {
  description = "An existing log analytics resource id for reuse"
  default     = ""
  type        = string
}
variable "existing_plink_subnet_id" {
  description = "An existing subnet id for reuse for the Private link resources"
  default     = ""
  type        = string
}


variable "existing_bastion_subnet_id" {
  description = "An existing subnet id for reuse for the Bastion host"
  default     = ""
  type        = string
}
variable "existing_app_service_subnet_id" {
  description = "An existing subnet id for reuse for the App Service delegation"
  default     = ""
  type        = string
}
variable "existing_vm_subnet_id" {
  description = "An existing subnet id for reuse for the Agent VMs"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_db_id" {
  description = "An existing private DNS zone for privatelink.database.windows.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_kv_id" {
  description = "An existing private DNS zone for privatelink.vaultcore.azure.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_blob_id" {
  description = "An existing private DNS zone for privatelink.blob.core.azure.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_queue_id" {
  description = "An existing private DNS zone for privatelink.queue.core.azure.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_dfs_id" {
  description = "An existing private DNS zone for privatelink.dfs.core.azure.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_purview_id" {
  description = "An existing private DNS zone for privatelink.purview.azure.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_purview_studio_id" {
  description = "An existing private DNS zone for privatelink.purviewstudio.azure.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_servicebus_id" {
  description = "An existing private DNS zone for privatelink.servicebus.windows.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_synapse_gateway_id" {
  description = "An existing private DNS zone for privatelink.azuresynapse.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_synapse_studio_id" {
  description = "An existing private DNS zone for privatelink.dev.azuresynapse.net"
  default     = ""
  type        = string
}

variable "existing_private_dns_zone_synapse_sql_id" {
  description = "An existing private DNS zone for privatelink.sql.azuresynapse.net"
  default     = ""
  type        = string
}

variable "existing_synapse_private_link_hub_id" {
  description = "An existing private link hub for synapse studio."
  default     = ""
  type        = string
}

variable "web_app_admin_security_group" {
  description = "A web app Azure security group used for admin access."
  default     = ""
  type        = string
}

variable "custom_vm_plan_name" {
  description = "An Azure vm plan name to be referenced for a custom vm image."
  default     = ""
  type        = string
}
variable "custom_vm_plan_product" {
  description = "An Azure vm plan product to be referenced for a custom vm image."
  default     = ""
  type        = string
}
variable "custom_vm_plan_publisher" {
  description = "An Azure vm plan publisher to be referenced for a custom vm image."
  default     = ""
  type        = string
}
variable "custom_vm_image_offer" {
  description = "An Azure custom image marketplace image offer to be referenced for a custom vm image."
  default     = ""
  type        = string
}
variable "custom_vm_image_publisher" {
  description = "An Azure custom image marketplace image publisher to be referenced for a custom vm image."
  default     = ""
  type        = string
}
variable "custom_vm_image_sku" {
  description = "An Azure custom image marketplace image sku to be referenced for a custom vm image."
  default     = ""
  type        = string
}
variable "custom_vm_image_version" {
  description = "An Azure custom image marketplace image version to be referenced for a custom vm image."
  default     = "latest"
  type        = string
}
# IXUP Encryption gateway VM
variable "ixup_egw_password" {
  description = "Password for the Encryption Gateway box"
  type        = string
}

variable "ixup_egw_vm_size" {
  description = "Size for Encryption Gateway Virtual Machine"
  default     = "Standard_B2s"
}
