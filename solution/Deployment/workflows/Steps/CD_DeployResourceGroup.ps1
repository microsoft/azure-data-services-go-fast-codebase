if($env:AdsOpts_CD_ResourceGroup_Enable -eq "True")
{
    Write-Debug "Creating Resource Group"
    $groupcreate = az group create --name $env:AdsOpts_CD_ResourceGroup_Name --location $env:AdsOpts_CD_ResourceGroup_Location
}

#Get ResourceGroup Object ID
$id = ((az group show --name $env:AdsOpts_CD_ResourceGroup_Name) | ConvertFrom-Json).id
#Save to Environment File
$environmentfile = $env:AdsOpts_CD_FolderPaths_Environments + "/" + $env:ENVIRONMENT_NAME + ".json"
$envsettings = Get-Content $environmentfile | ConvertFrom-Json
$envsettings.AdsOpts.CD.ResourceGroup.Id = $id
$envsettings | ConvertTo-Json  -Depth 10 | set-content $environmentfile

