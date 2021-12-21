# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.90.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.13.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "=3.1.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  subscription_id            = var.subscription_id
  skip_provider_registration = true
}

provider "azuread" {
  tenant_id = var.tenant_id
}

data "azurerm_client_config" "current" {
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  prefix = [
    var.prefix,
    var.environment_tag
  ]
  suffix = [
    var.app_name
  ]
}


resource "random_id" "rg_deployment_unique" {
  byte_length = 4
}