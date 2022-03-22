
# Developer Installation Instructions
If you want to deploy a once off lockbox for development purposes, the following steps can be used.
## :hammer: Tools & Environment
This solution makes use of development containers feature of GitHub / VsCode. Use the following guidance to get started with dev containers:
- https://code.visualstudio.com/docs/remote/containers

This will save you having to install any of the tooling dependencies and will ensure you have the correct versions of everything installed. 

**:warning: NOTE:** For all scripts, be sure that your working directory is set to the DeploymentV2 folder.

## :green_circle: PART 1. Prepare your Azure enviromnent using Prepare.ps1 script
### :page_with_curl: Pre-requisites
Before you run the **Deploy.ps1** script, make sure you have completed the pre-requisites:
 
 - Run **az login** to login with the Azure CLI
 - Use **az account set** to select the correct subscrption using
 - Ensure you have Contributor or Owner role on the Azure Subscription you are preparing

### :grey_question: What does it do?
The purpose of this script is to prepare your Azure environment ready for the deployment, it will perform the following:
 - Register the Azure Resource Providers
 - Create your Azure Resource Group
 - Create your Azure Storage Account for Terraform state store

### 	:arrow_forward: How do I run this?
Execute the following script file:
```./Prepare.ps1```
When you execute the script it will ask you for two inputs:
 - **Resource Group Name**: The resource group name to be created. If you skip this, only the providers will be registered
 - **Storage Account Name** The storage account name for storing your terraform state. If you skip this, no storage account will be created
 
At the end of the execution, you will be provided the details of what was performed as well as the resource & subscription details.
These are pre-loaded into environment variables so that you can directly run the ./Deploy.ps1 without doing any manual entry.

To save you having to do more work later, I recommend that you copy them down and updatethe values directly into the following file:

 ```/azure-data-services-go-fast-codebase/solution/DeploymentV2/terraform/vars/local/terragrunt.hcl```

 This file is used by the ./Deploy.ps1 script by default and will be used if no enviroment vars are available

## :green_circle: PART 2. Deploy your Lockbox using Deploy.ps1 script
### :page_with_curl: Pre-requisites
Before you run the **Deploy.ps1** script, make sure you have completed the pre-requisites:
- Run the Prepare.ps1 script first. This will prepare your azure subscription for deployment
- Ensure that you have run az login and az account set
- Ensure you have Owner access to the resource group you are planning on deploying into
- Ensure you have the Application Administrator role with Azure AD to allow you to create AAD app registrations

### :grey_question: What does it do?
This script will:
 - Deploy all infra resources using terra
 - Approve all private link requests
 - Build and deploy web app
 - Build and deploy function app
 - Build database app and deploy
 - Deploy samples into blob storage
 
### 	:arrow_forward: How do I run this?
Execute the following script file:
```./Deploy.ps1```
You can run this script multiple times if needed.
The configuration for this environment creation is read from the following locations:
- The environment variables created when you ran Prepare.ps1
- The environment configuration file:
  -  ```/azure-data-services-go-fast-codebase/solution/DeploymentV2/terraform/vars/local/terragrunt.hcl```
