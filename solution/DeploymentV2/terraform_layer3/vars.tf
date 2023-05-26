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

#---------------------------------------------------------------
# Feature Toggles
#---------------------------------------------------------------

variable "deploy_rbac_roles" {
  description = "Feature toggle for deploying the RBAC roles that are deployed alongside resources"
  default     = true
  type        = bool
}

variable "deploy_data_factory" {
  description = "Feature toggle for deploying the Azure Data Factory"
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

variable "deploy_purview" {
  description = "Feature toggle for deploying Azure Purview"
  default     = false
  type        = bool
}

variable "deploy_purview_sp" {
  description = "Feature toggle for deploying Azure Purview SP IR"
  default     = false
  type        = bool
}

variable "private_endpoint_register_private_dns_zone_groups" {
  description = "Whether to register private endpoints against the relevant private dns zone group."
  default     = true
  type        = bool
}

variable "purview_ingestion_endpoint_type" {
  description = "Whether to use the arm template or terraform to deploy the purview ingestion endpoints. Must be either 'arm' or 'terraform' value."
  default     = "arm"
  type        = string
}


variable "is_vnet_isolated" {
  description = "Whether to deploy the resources as vnet attached / private linked"
  default     = true
  type        = bool
}



#---------------------------------------------------------------
# User Access and Ownership/
#---------------------------------------------------------------

variable "azure_sql_aad_administrators" {
   description = "List of Azure SQL Administrators"
   type = map(string)
   default = {}
}

variable "azure_purview_data_curators" {
   description = "List of Azure Purview Data Curators for default root"
   type = list(string)
   default = []
}

variable "resource_owners" {
  description = "A web app Azure security group used for admin access."
  default = {	
  }
  type        = map(string)
}

#---------------------------------------------------------------
# Terraform Toggles
#---------------------------------------------------------------

variable "remove_lock" {
  description = "Set to true to remove the Terraform Lock."
  default     = false
  type        = bool
}

variable "lock_id" {
  description = "ID of Terraform Lock should the lock need to be removed."
  type        = string
  default     = "#####"
}

variable "terraform_plan" {
  description = "Specify the layer to run a Terraform plan."
  type        = string
  default     = "#####"

  validation {
    condition     = contains(["#####", "layer0", "layer1", "layer2", "layer3"], var.terraform_plan)
    error_message = "Valid values for var: terraform_plan are (#####, layer0, layer1, layer2, layer3)."
  }
}