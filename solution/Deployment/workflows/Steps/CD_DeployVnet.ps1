#SetServiceName -RootElement "AdsOpts_CD_Services_Vnet"

if($env:AdsOpts_CD_Services_Vnet_Enable -eq "True")
{
    Write-Debug " Creating Vnet + Subnets (Bastion, Data, WebApp)"
    Write-Debug $env:AdsOpts_CD_Services_Vnet_Name

    #vNet
    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/Networking.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location vnet-name=$env:AdsOpts_CD_Services_Vnet_Name vnet-address-prefix=$env:AdsOpts_CD_Services_Vnet_vNetAddressRange `
    bastion-subnet-ip-prefix=$env:AdsOpts_CD_Services_Vnet_BastionSubnetAddressRange `
    data-subnet-ip-prefix=$env:AdsOpts_CD_Services_Vnet_DataSubnetAddressRange `
    webapp-subnet-ip-prefix=$env:AdsOpts_CD_Services_Vnet_WebAppSubnetAddressRange `
    funcapp-subnet-ip-prefix=$env:AdsOpts_CD_Services_Vnet_FuncAppSubnetAddressRange `
    bastion-host-name=$env:AdsOpts_CD_Services_Bastion_Name `
    bastion-subnet-name=$env:AdsOpts_CD_Services_Vnet_BastionSubnetName `
    data-subnet-name=$env:AdsOpts_CD_Services_Vnet_DataSubnetName `
    webapp-subnet-name=$env:AdsOpts_CD_Services_Vnet_WebAppSubnetName `
    funcapp-subnet-name=$env:AdsOpts_CD_Services_Vnet_FuncAppSubnetName

    Write-Debug " Creating Vnet"
}
else 
{
    Write-Warning "Skipped Creation of Vnet"
}