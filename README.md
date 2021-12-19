# Azure Data Services Go Fast Codebase

## Introduction

The Azure Data Services Go Fast Codebase is a combination of Microsoft components designed to shorten the "time to value" when deploying an Azure Data Platform. Key features include:

- Infrastucture as code (IAC) deployment of MVP Azure Data Platform 
- "Out of the box" Continuous Integration and Continuous Deployment framework  
- Enterpise grade security and monitoring with full support for Key Vault, VNETS, Private Enpoints and Managed Service Identities
- Codeless Ingestion from commonly used enterprise source systems into an enterprise data lake
- Users can interact with capabilities through a webpage and embedded dashboards.

This project is composed of Microsoft components and Open-Source Software (OSS) and is provided to customers and partners at no charge. 

At its core this project is intended to be an accelerator. As such, it is designed to accelerate the “time to value” in using the Microsoft components. As an accelerator, is it not for sale, nor is it a supported product.  

---

## Getting Started

Getting started is always the hardest part of any process so help clients & partners get started with this repository we provide a set of online, on-boarding and upskilling workshops. Spaces in these workshops are limited and subject to an application process. If you are intersted then please 
nominate yourself at [https://forms.office.com/r/qbQrU6jFsj](https://forms.office.com/r/qbQrU6jFsj).
  

### Prerequisites

Deployment of this project requires a variety of services across Azure. Please ensure that you have access to these services before continuing on to the deployment section of this guide.

>To get started you will need the following:
>
>- An active Azure Subscription & Empty Resource Group*
>- Owner rights on the Azure Resource Group
>- Power BI Workspace (Optional)

*Note that for a fully functioning deployment the deployment process will create a Deployment Service principal and two Azure Application Registrtions within the Azure Active Directory (AAD) domain that is connected to your Azure subscription. It is recommended that you use an Azure subscription and AAD on which you have the necessary priveleges to perform these operations. 

You can sign up for an Azure subscription [here](https://azure.microsoft.com/en-us/free/) 

Once you have your Prerequisite items, please move on to the Deployment Configuration step.

---

## Deployment Configuration

You will also need some development tools to edit and run the deployment scripts provided. It is recommended you use the following:
>
>- A windows based computer (local or cloud)
>- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/)
>- [Docker Desktop](https://www.docker.com/products/docker-desktop)
>- [Windows Store Ubuntu 18.04 LTS](https://www.microsoft.com/store/productId/9N9TNGVNDL3Q)

The deployment uses a concept of **Developing inside a Container** to containerize all the necessary pre-requisite components without requiring them to be installed on the local machine. Follow our [Configuring your System for Development Containers](https://code.visualstudio.com/docs/remote/containers) guide.

Once you have set up these pre-requisites you will then need to [Clone](https://docs.github.com/en/enterprise-server@3.1/repositories/creating-and-managing-repositories/cloning-a-repository) this repository to your local machine. 

## Deployment
To deploy the solution open **Visual Studio Code** and carry out the following steps.

>- [ ] From the menu select "File" then "Open Folder". Navigate the directory into which you cloned the solution and from there to "solution/Deployment". Choose this folder to open in Visual Studio Code. 
>- [ ] Next, from the menu, select "View", "Command Palette". When the search box opens type "Remote-Containers: Reopen in Container". **Note** that you Docker Desktop needs to be running before you perform this step. 
>- [ ] From the menu select "Terminal", "New Terminal". A new Powershell Core window will open at the bottom of your screen. You are now running within the Docker container.
>- [ ] Deployment specifics are controlled by an environment file. You can set these specifics using a small node web application that is embedded within the source code. To access the application use the Terminal window that was creeated in the previous step and type the following commands: 
```bash
bash
cd environments/Node/
npm install 
node server.js 
```
>- [ ] Next Open an Internet Browser and navigate to http://localhost:8080/EditSettings.html. You  should see a screen that looks like the picture below. For a vanilla deployment you only need to fill out the section titled "Primary Resource Group Settings". Fill this out now with your Azure Environment Specifics and, once done, click on the red button at the top of the form labelled "Click here to update the environment file with form changes". 

![Form](./documentation/images/DeploymentForm.png)

>- [ ] Next return to the terminal window and press "Ctrl+c" twice to stop your Node application. Next log in to Azure and check that you are using the right subscription by using the following commands:

```powershell
pwsh
az login #Logs you in to your Azure environment 
az account show
```
>- [ ] Next return to the terminal window and use the following commands to access the directory which contains the deployment scripts and list its contents:

```powershell
pwsh
cd ../../workflows/
ls
```

>- [ ] You will now see a listing of powershell (*.ps1) files. These are the scripts that drive the deployment. To deploy the solution run the commands below in your terminal window. **Note** it is recommended that you run these one at a time and check output during each command execution for errors. 
```powershell
./LocalDevOnly_EnvironmentSetUp.ps1 #Loads your environment settings
./CI_1a_BuildCode.ps1 #Builds the source code binaries 
./CD_0a_CreateServicePrincipals_AAD_Elevated.ps1 #Creates your Azure resource group and application registrations
./CD_1a_DeployServices.ps1 #Deploys the core Azure Services     
./CD_2a_CreateMSIs_AAD_Elevated.ps1 #Sets up the Azure Managed Service Identities and grants privileges and access
./CD_2b_ConfigureServices.ps1 #Publishes source code to Azure Services.
```

## Post Deployment Set-up and Instructions
=======
The deployment uses a concept of **Developing inside a Container** to containerize all the necessary pre-requisite component without requiring them to be installed on the local machine. Follow our [Configuring your System for Development Containers](https://code.visualstudio.com/docs/remote/containers) guide.

---

## Cost Estimator

Coming Soon.

---

## Navigating the Source Code

This  has the following structure:

Folder/File | Description
--- | ---
solution/ | Primary source code folder with sub-directories for each core technology
solution/Database | Contains source code for the meta-data database and sample databases
solution/Deployment | Contains CICD code 
solution/Diagrams | Contains a Structurizr diagramming project used for creation of architectural diagrams
solution/FunctionApp | Contains source code for the ADS Go Fast Orchestration Functions
solution/PowerBi | Contains source code for the Power BI files that can be used to provide reporting
solution/WebApplication | Contains source code for the ADS Go Fast web front end
---

## Contributing 

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Security
Microsoft takes the security of our software products and services seriously, which includes all source code repositories managed through our GitHub organizations, which include Microsoft, Azure, DotNet, AspNet, Xamarin, and our GitHub organizations. Please review this repository's [security section](../../security) for more details.

## Privacy
Microsoft values your privacy. See the [Microsoft Privacy Statement](https://privacy.microsoft.com/en-GB/data-privacy-notice) for more information

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
