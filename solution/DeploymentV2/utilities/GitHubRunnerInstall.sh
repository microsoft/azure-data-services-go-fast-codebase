sudo apt-get update  && \
sudo apt-get install -y wget apt-transport-https software-properties-common && \
wget -q https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/powershell-lts_7.2.5-1.deb_amd64.deb  && \
sudo dpkg -i powershell-lts_7.2.5-1.deb_amd64.deb  && \
rm ./powershell-lts_7.2.5-1.deb_amd64.deb  && \
sudo apt install -y dotnet-sdk-6.0  && \

#May need to do below on ubuntu 20.04
sudo apt install -y aspnetcore-runtime-6.0=6.0.8-1 dotnet-apphost-pack-6.0=6.0.8-1 dotnet-host=6.0.8-1 dotnet-hostfxr-6.0=6.0.8-1 dotnet-runtime-6.0=6.0.8-1 dotnet-sdk-6.0=6.0.400-1 dotnet-targeting-pack-6.0=6.0.8-1

wget https://github.com/google/go-jsonnet/releases/download/v0.17.0/jsonnet-go_0.17.0_linux_amd64.deb  && \
sudo dpkg -i jsonnet-go_0.17.0_linux_amd64.deb && \
sudo rm jsonnet-go_0.17.0_linux_amd64.deb && \
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
sudo apt-get update && sudo apt-get install terraform && \
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.14/terragrunt_linux_amd64 && \
sudo mv terragrunt_linux_amd64 terragrunt && \
sudo chmod u+x terragrunt && \
sudo mv terragrunt /usr/local/bin/terragrunt && \
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash