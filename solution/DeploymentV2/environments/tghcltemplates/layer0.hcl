locals {
  common_vars = jsondecode(file("../../../bin/environments/<@environment>/common_vars_for_hcl.json"))
}

/*If performing a private networking deployment Prepare.ps1 will initially set TF_VAR_layer0_state to 'local' after initial deployment this should be set to 'remote'*/
generate "backend.tf" {
  
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  %{ if get_env("TF_VAR_layer0_state") == "local"}
  terraform {
    backend "local" {                       
      path                  = "./terraform_layer0.tfstate"      
    }
  }
  %{ endif }
  %{ if get_env("TF_VAR_layer0_state","local") == "remote"}
  terraform {
    backend "azurerm" {                 
      container_name       = "tstate"
      key                  = "terraform_layer0.tfstate"
      resource_group_name  = "${local.common_vars.resource_group_name}"
      storage_account_name = "${local.common_vars.state_storage_account_name}"      
    }
  }
  %{ endif }
  EOF 
  
}