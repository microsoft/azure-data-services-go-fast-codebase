#!/bin/bash
# VALIDATED ON Linux (ubuntu 22.04) #

# This script installs the GitHub Actions Runner on a Ubuntu 22.04 system. It starts by creating a new directory called "actions-runner" and then navigating into it. 
# Next, it uses the curl command to download the latest version of the runner package, specifically version 2.296.0. 
# It then uses the tar command to extract the package. After that, it prompts the user to enter the GitHub token and repository URL. 
# Once entered, it uses the config.sh script to configure the runner with the provided URL and token. 
# Then it removes the downloaded tarball file and use the svc.sh script with install and start options to install and start the GitHub Actions Runner service. 
# This script should be run as a user with administrator privilege.


#Github Runner Software
mkdir actions-runner && cd actions-runner# Download the latest runner package && \
curl -o actions-runner-linux-x64-2.296.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.296.0/actions-runner-linux-x64-2.296.0.tar.gz && \
tar xzf ./actions-runner-linux-x64-2.296.0.tar.gz 
read -p "Please enter github runner token: " GHTOKEN 
read -p "Please enter github repo url eg. https://github.com/microsoft/azure-data-services-go-fast-codebase  " GHURL 
./config.sh --url $GHURL --token $GHTOKEN
rm actions-runner-linux-x64-2.296.0.tar.gz 
sudo ./svc.sh install 
sudo ./svc.sh start

