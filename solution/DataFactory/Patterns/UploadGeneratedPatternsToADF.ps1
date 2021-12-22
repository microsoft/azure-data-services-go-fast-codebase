function UploadADFItem ($items) {
    if ($items.count -gt 0) {
        $items | Foreach-Object {
            $lsName = $_.BaseName 
            $fileName = $_.FullName
            $jsonobject = $_ | Get-Content | ConvertFrom-Json

            $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/"

            if ($jsonobject.type -eq "Microsoft.DataFactory/factories/linkedservices") {
                #Swap out Key Vault Url for Function App Linked Service
                if ($lsName -eq "AdsGoFastKeyVault") {
                    $jsonobject.properties.typeProperties.baseUrl = "https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/"
                }

                #Swap out Function App Url
                if ($lsName -eq "SLS_AzureFunctionApp") {
                    $jsonobject.properties.typeProperties.functionAppUrl = "https://$env:AdsOpts_CD_Services_CoreFunctionApp_Name.azurewebsites.net"
                }
            
                $uri = $uri + "linkedservices/"
            }
            if ($jsonobject.type -eq "Microsoft.DataFactory/factories/datasets") {            
                $uri = $uri + "datasets/"
            }
            if ($jsonobject.type -eq "Microsoft.DataFactory/factories/pipelines") {            
                $uri = $uri + "pipelines/"
            }
        
            #ParseOut the Name Attribute
            $name = $jsonobject.name
            $uri = $uri + $name
            #Persist File Back
            $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_

            #Make a copy of the file for upload 
            Copy-Item  -Path $fileName -Destination "FileForUpload.json"

            write-host ($lsName) -ForegroundColor Yellow -BackgroundColor DarkGreen
                        
            write-host $uri
            $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'


        }
    }
}


$UploadGDS = $false
$UploadGLS = $true

if($UploadGLS -eq $true)
{
    $items = (Get-ChildItem -Path "./output/" -Include "GLS*.json" -Verbose -recurse)
    UploadADFItem -items $items 
    $items = (Get-ChildItem -Path "./output/" -Include "SLS*.json" -Verbose -recurse)
    UploadADFItem -items $items 
}

if($UploadGDS -eq $true)
{
    $items = (Get-ChildItem -Path "./output/" -Include "GDS*.json" -Verbose -recurse)
    UploadADFItem -items $items
}

Write-Host "_____________________________"
Write-Host "Level 0 Pipelines"
Write-Host "_____________________________"
$items = (Get-ChildItem -Path "./output/" -Include "GPL0_*.json"  -Verbose -recurse)
UploadADFItem -items $items
Write-Host "_____________________________"
Write-Host "Level 1 Pipelines"
Write-Host "_____________________________"
$items = (Get-ChildItem -Path "./output/" -Include "GPL1_*.json"  -Verbose -recurse)
UploadADFItem -items $items
Write-Host "_____________________________"
Write-Host "Level 2 Pipelines"
Write-Host "_____________________________"
$items = (Get-ChildItem -Path "./output/" -Include "GPL2_*.json" -Verbose -recurse)
UploadADFItem -items $items
Write-Host "_____________________________"
Write-Host "Top Level Pipelines"
Write-Host "_____________________________"
$items = (Get-ChildItem -Path "./output/" -Include "GPL_*.json" -Verbose -recurse)
UploadADFItem -items $items