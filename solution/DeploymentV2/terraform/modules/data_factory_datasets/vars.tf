variable "resource_group_name" {
  description = "The name of the resource group to deploy into"
  type        = string
}
variable "is_azure" {
  description = "Is the integration runtime azure hosted?"
  type        = bool
}
variable "integration_runtime_name" {
  description = "The name of the integration runtime"
  type        = string
}
variable "integration_runtime_short_name" {
  description = "The name of the integration runtime"
  type        = string
}
variable "data_factory_name" {
  description = "The name of the data factory"
  type        = string
}
variable "data_lake_linkedservice_name" {
  description = "The name of the linked service for data lake"
  type        = string
}
variable "blob_linkedservice_name" {
  description = "The name of the linked service for blob"
  type        = string
}
variable "azure_sql_linkedservice_name" {
  description = "The name of the linked service for AZURE SQL server"
  type        = string
}

variable "mssql_linkedservice_name" {
  description = "The name of the linked service for SQL server"
  type        = string
}

variable "fileserver_linkedservice_name" {
  description = "The name of the linked service for File Server"
  type        = string
}
variable "name_suffix" {
  description = "Used to give resource group deployments unique names for an environment"
  type        = string
}