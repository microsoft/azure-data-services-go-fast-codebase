variable "resource_group_name" {
  description = "The name of the resource group to deploy into"
  type        = string
}

variable "data_factory_name" {
  description = "The name of the data factory"
  type        = string
}
variable "shared_keyvault_uri" {
  description = "The uri of the shared keyvault"
  type        = string
}


variable "integration_runtime_name" {
  description = "The name of the integration runtime"
  type        = string
}

variable "integration_runtime_short_name" {
  description = "The short name of the integration runtime"
  type        = string
}
variable "name_suffix" {
  description = "Used to give resource group deployments unique names for an environment"
  type        = string
}