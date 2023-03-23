#!/bin/bash
# VALIDATED ON Linux (ubuntu 22.04) #

# This script installs the following on a Ubuntu 22.04 system:
# PV
# PowerShell 7.3.0
# ASP.NET Core runtime 6.0, the .NET Core SDK 6.0, and other related components
# Jsonnet-go 0.17.0
# Terraform 0.xx (Latest - TODO - Lock to specific version)
# Terragrunt 0.35.14
# Azure CLI
# Figlet, Lolcat and Boxes
# It first updates the package list, installs some necessary dependencies, then downloads and installs each of the above items. It also removes any intermediate downloaded files to clean up the system.


# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
# Clear the color after that
clear='\033[0m'

#Pv
echo -e "${yellow}Installing PV...${clear}!"
sudo apt install pv -y

#PowerShell
echo -e "${yellow}Installing Powershell...${clear}!"
sudo apt-get update 
sudo apt-get install -y wget apt-transport-https software-properties-common 
wget -q https://github.com/PowerShell/PowerShell/releases/download/v7.3.0/powershell_7.3.0-1.deb_amd64.deb --show-progress 
sudo dpkg -i powershell_7.3.0-1.deb_amd64.deb  
rm ./powershell_7.3.0-1.deb_amd64.deb  

#Dotnet SDK
echo -e "${yellow}Installing DotNet SDK...${clear}!"
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb  --show-progress 
sudo dpkg -i packages-microsoft-prod.deb 
sudo apt-get update 
sudo apt install -y aspnetcore-runtime-6.0=6.0.8-1 dotnet-apphost-pack-6.0=6.0.8-1 dotnet-host=6.0.8-1 dotnet-hostfxr-6.0=6.0.8-1 dotnet-runtime-6.0=6.0.8-1 dotnet-sdk-6.0=6.0.400-1 dotnet-targeting-pack-6.0=6.0.8-1 --allow-downgrades 
rm packages-microsoft-prod.deb 

echo -e "${yellow}Installing JSONNet...${clear}!"
wget https://github.com/google/go-jsonnet/releases/download/v0.17.0/jsonnet-go_0.17.0_linux_amd64.deb  
sudo dpkg -i jsonnet-go_0.17.0_linux_amd64.deb 
sudo rm jsonnet-go_0.17.0_linux_amd64.deb 

echo -e "${yellow}Installing Terraform...${clear}!"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - 
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
sudo apt-get update && sudo apt-get install terraform -y

echo -e "${yellow}Installing Terragrunt...${clear}!"
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.14/terragrunt_linux_amd64 
sudo mv terragrunt_linux_amd64 terragrunt 
sudo chmod u+x terragrunt 
sudo mv terragrunt /usr/local/bin/terragrunt 

echo -e "${yellow}Installing AzureCLI...${clear}!"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 

echo -e "${yellow}Installing Boxes figlet and lolcat...${clear}!"
#Boxes, Figlet and LolCat
sudo apt-get install figlet lolcat boxes -y 