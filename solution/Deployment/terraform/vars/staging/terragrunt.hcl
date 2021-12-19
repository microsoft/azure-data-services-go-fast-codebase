remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "ark-stg-rg-ads"
    storage_account_name = "arkstgstadsstate"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
  }
}


inputs = {
  tenant_id                             = "0fee3d31-b963-4a1c-8f4a-ca367205aa65"
  subscription_id                       = "03a36be0-8f6a-4436-a9f5-499ba3c77823"
  resource_location                     = "Australia East"
  resource_group_name                   = "ark-stg-rg-ads"
  owner_tag                             = "arkahna.io"
  environment_tag                       = "stg"  
  ip_address                            = "203.123.100.64"
}