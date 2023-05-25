# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.47.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.28.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "=1.6.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "=3.3.2"
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
  version = "0.2.0"
  unique-seed = data.terraform_remote_state.layer1.outputs.naming_unique_seed
  prefix = [
    var.prefix,
    var.environment_tag
  ]
  suffix = [
    var.app_name
  ]
}

provider "databricks" {
  alias = "created_workspace"
  host = var.deploy_databricks ? azurerm_databricks_workspace.workspace[0].workspace_url : ""
  azure_workspace_resource_id = var.deploy_databricks ? azurerm_databricks_workspace.workspace[0].id : ""
  //auth_type  = "azure-cli"
  //azure_use_msi = true
}

resource "random_id" "rg_deployment_unique" {
  byte_length = 4
}
