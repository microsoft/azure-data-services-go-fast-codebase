# Setting up a new environment
This section describes how to set up a new environment. It is suggested that for development purposes, developers use their own unique development environment, i.e. a separate resource group, storage account and Terraform state file.


# Setting up Infrastructure from Local Machine
This describes how to run the Terraform configuration from your local machine. We will be running with local state and not persisting to a remote state store. 

## Run Terraform/Terragrunt locally
Log into environment as yourself and change to infra directory. This is a quick way to get going but doesn't test the permissions of the account which will be actually deploying.

``` PowerShell
az login
az account set --subscription <Subscription ID>
```

``` PowerShell
terragrunt init --terragrunt-config vars/local/terragrunt.hcl -reconfigure
terragrunt plan --terragrunt-config vars/local/terragrunt.hcl
terragrunt apply --terragrunt-config vars/local/terragrunt.hcl
```

``` PowerShell
terragrunt init --terragrunt-config vars/staging/terragrunt.hcl -reconfigure
terragrunt plan --terragrunt-config vars/staging/terragrunt.hcl
terragrunt apply --terragrunt-config vars/staging/terragrunt.hcl
```

# Setting up Infrastructure for CI/CD managed environment
This describes how to run the Terraform configuration to create the state store for an environment. This should be run once per environment and provides the location for terraform state to be stored.

## Set up Terraform state
This will set up a resource group, storage account and container to be used for Terraform state. The same resource group will be used for deployed artefacts.

Run PowerShell

Log into environment.

``` PowerShell
az login
az account set --subscription <Subscription ID>
```

Edit *infrastructure\state\create-state-store.ps1* so that *$RESOURCE_GROUP_NAME* and *$RESOURCE_GROUP_NAME* reflect the environment.

Run the script to create the resources.

## Set up Terragrunt config file
Set up the config file in location *infrastructure\vars\<environment>\terragrunt.hcl*

Set *remote_state.config.resource_group_name* and *remote_state.config.storage_account_name* as appropriate for the environment, and point to the resource group and storage created above.

Set up the *inputs* section to reflect the environment being deployed to.


## Init the state for the environment
Run PowerShell

Log into environment and change to infra directory.

``` PowerShell
az login
az account set --subscription <Subscription ID>
cd infrastructure
```

Initialise state

``` PowerShell
cd infrastructure
terragrunt init --terragrunt-config vars/development/terragrunt.hcl
```


# Required Azure resource providers
Microsoft.Storage
Microsoft.Network
Microsoft.Web
microsoft.insights
Microsoft.ManagedIdentity
Microsoft.KeyVault
Microsoft.OperationalInsights
Microsoft.Purview
Microsoft.EventHub
Microsoft.Compute

