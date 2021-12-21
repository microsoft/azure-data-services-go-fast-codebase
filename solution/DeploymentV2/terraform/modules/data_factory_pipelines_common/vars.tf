variable "resource_group_name" {
  description = "The name of the resource group to deploy into"
  type        = string
}

variable "data_factory_name" {
  description = "The name of the data factory"
  type        = string
}

variable "linkedservice_azure_function_name" {
  description = "The name of the linked service for azure function"
  type        = string
}
variable "name_suffix" {
  description = "Used to give resource group deployments unique names for an environment"
  type        = string
}