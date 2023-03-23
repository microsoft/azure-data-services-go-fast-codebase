#!/bin/bash
# VALIDATED ON Linux (ubuntu 22.04) #

# This script installs the following on a Ubuntu 22.04 system:
# PV
# PowerShell 7.3.0
# ASP.NET Core runtime 6.0, the .NET Core SDK 6.0, and other related components
# Azure CLI
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

#azure cli
echo -e "${yellow}Installing AzureCLI...${clear}!"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash