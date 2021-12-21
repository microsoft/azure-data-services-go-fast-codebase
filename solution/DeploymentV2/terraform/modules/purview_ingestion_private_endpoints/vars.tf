variable "resource_group_name" {
  description = "The name of the resource group to deploy into"
  type        = string
}

variable "purview_account_name" {
  description = "The name of the data factory"
  type        = string
}
variable "resource_location" {
  description = "The uri of the shared keyvault"
  type        = string
}


variable "queue_privatelink_name" {
  description = "The name of the queue private link"
  type        = string
}

variable "storage_privatelink_name" {
  description = "The name of the storage private link"
  type        = string
}

variable "eventhub_privatelink_name" {
  description = "The name of the eventhub private link"
  type        = string
}

variable "subnet_id" {
  description = "The id of the subnet to attach the purview ingestion resources"
  type        = string
}
variable "managed_resource_group_name" {
  description = "The name of the purview managed resource group"
  type        = string
}
variable "name_suffix" {
  description = "Used to give resource group deployments unique names for an environment"
  type        = string
}

