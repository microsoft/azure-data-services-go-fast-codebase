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
  default     = "arkahna.io"
}

variable "author_tag" {
  description = "The tags to apply to resources."
  type        = string
  default     = "arkahna.io"
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
  description = "CIDR of the subnet used to host VMs"
  type        = string
  default     = "10.0.0.192/26"
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
  description = "Feature toggle for deploying the Azure Purview"
  default     = false
  type        = bool
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
variable "synapse_name" {
  description = "The override name for the Synapse workspace component. If empty, will be autogenerated based on prefix settings"
  default     = ""
  type        = string
}
variable "purview_name" {
  description = "The override name for the Purview component. If empty, will be autogenerated based on prefix settings"
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


