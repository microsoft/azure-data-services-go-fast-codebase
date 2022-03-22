# Create ADF Diagnostic Settings
$logsSetting = "[{'category':'ActivityRuns','enabled':true,'retentionPolicy':{'days': 30,'enabled': true}},{'category':'PipelineRuns','enabled':true,'retentionPolicy':{'days': 30,'enabled': true}},{'category':'TriggerRuns','enabled':true,'retentionPolicy':{'days': 30,'enabled': true}}]".Replace("'",'\"')
$metricsSetting = "[{'category':'AllMetrics','enabled':true,'retentionPolicy':{'days': 30,'enabled': true}}]".Replace("'",'\"')

$result = az monitor diagnostic-settings create --name ADF-Diagnostics --export-to-resource-specific true --resource "$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name" --logs $logsSetting --metrics $metricsSetting --storage-account "$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_Logging_Name" --workspace "$env:AdsOpts_CD_ResourceGroup_Id/providers/microsoft.operationalinsights/workspaces/$env:AdsOpts_CD_Services_LogAnalytics_Name"

#Create IRs

#Create Managed Network
$subid = (az account show -s $env:AdsOpts_CD_ResourceGroup_Subscription | ConvertFrom-Json).id
$uri = "https://management.azure.com/subscriptions/$subid/resourceGroups/$env:AdsOpts_CD_ResourceGroup_Name/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/managedVirtualNetworks/default" + '?api-version=2018-06-01'

$rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body '{\"properties\": {}}'

#VNET
$body = '
{
    "properties": {
        "type": "Managed",
        "typeProperties": {
            "computeProperties": {
                "location": "AutoResolve",
                "dataFlowProperties": {
                    "computeType": "General",
                    "coreCount": 8,
                    "timeToLive": 10,
                    "cleanup": true
                }
            }
        },
        "managedVirtualNetwork": {
            "type": "ManagedVirtualNetworkReference",
            "referenceName": "default"
        }
    }
}' | ConvertFrom-Json
$body = ($body | ConvertTo-Json -compress  -Depth 10 | Out-String).Replace('"','\"')
$uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/integrationRuntimes/$env:AdsOpts_CD_Services_DataFactory_AzVnetIr_Name" + '?&api-version=2018-06-01'
Write-Host "Creating IR: $env:AdsOpts_CD_Services_DataFactory_AzVnetIr_Name"
$rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body $body 

#On Prem - Note we are using a managed VNET IR to mimic on prem
# $body = '
# {
#     "properties": {
#         "type": "Managed",
#         "typeProperties": {
#             "computeProperties": {
#                 "location": "AutoResolve",
#                 "dataFlowProperties": {
#                     "computeType": "General",
#                     "coreCount": 8,
#                     "timeToLive": 10,
#                     "cleanup": true
#                 }
#             }
#         },
#         "managedVirtualNetwork": {
#             "type": "ManagedVirtualNetworkReference",
#             "referenceName": "default"
#         }
#     }
# }' | ConvertFrom-Json

if (([Environment]::GetEnvironmentVariable("AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Enable")) -eq "True")
{
    $body = '
    {
        "properties": {
            "type": "SelfHosted"
        }
    }' | ConvertFrom-Json

    $body = ($body | ConvertTo-Json -compress  -Depth 10 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/integrationRuntimes/$env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Name" + '?&api-version=2018-06-01'
    Write-Host "Creating IR: $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Name"
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body $body 
}

$IRA_PostFix = "_" + $env:AdsOpts_CD_Services_DataFactory_AzVnetIr_Name
$IRB_PostFix = "_" + $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Name

$dfbase = "$env:AdsOpts_CD_FolderPaths_PublishUnZip/datafactory"

#Data Factory - LinkedServices
Get-ChildItem "$dfbase/linkedService" -Filter *.json | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName
    $jsonobject = $_ | Get-Content | ConvertFrom-Json

    #Swap out Key Vault Url for Function App Linked Service
    if($lsName -eq "AdsGoFastKeyVault")
    {
        $jsonobject.properties.typeProperties.baseUrl = "https://$env:AdsOpts_CD_Services_KeyVault_Name.vault.azure.net/"
    }

    #Swap out Function App Url
    if($lsName -eq "AzureFunctionAdsGoFastDataLakeAccelFunApp")
    {
        $jsonobject.properties.typeProperties.functionAppUrl = "https://$env:AdsOpts_CD_Services_CoreFunctionApp_Name.azurewebsites.net"
    }
    
    #ParseOut the Name Attribute
    $name = $jsonobject.name

    #Persist File Back
    $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_

    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"

    write-host ("LinkedService:" + $lsName) -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2LinkedService -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -force
    $body = ($jsonobject | ConvertTo-Json -compress  -Depth 10 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/linkedservices/$name" 
    write-host $uri
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'


}

#Data Factory - Dataset
Get-ChildItem "$dfbase/dataset" -Filter *.json | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName

    #ParseOut the Name Attribute
    $jsonobject = $_ | Get-Content | ConvertFrom-Json
    $name = $jsonobject.name

    #Persist File Back
    $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_

    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"

    write-host ("Dataset: " + $fileName) -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2Dataset -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -Force
    $body = ($jsonobject | ConvertTo-Json -compress  -Depth 10 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/datasets/$name" 
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'
    

}


#Move to pipelines directory
$CurrentPath = (Get-Location).Path
Set-Location "..\bin\publish\unzipped\datafactory\pipeline"


#Data Factory - Pipelines
Write-Host "Starting Pipelines" 
Write-Host "Uploading Level 0 Dependencies" 
Get-ChildItem "./" -Recurse -Include "AZ_Function*.json", "AZ_SQL_Watermark_IR*.json",  "SH_SQL_Watermark_IR*.json" | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName
    
    #ParseOut the Name Attribute
    $jsonobject = $_ | Get-Content | ConvertFrom-Json
    $name = $jsonobject.name

    #Persist File Back
    $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_

    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"


    write-host $fileName -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2Pipeline -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -force
    #$body = ($jsonobject | ConvertTo-Json -compress  -Depth 100 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/pipelines/$name" 
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'

}

Write-Host "Uploading Level 1 Dependencies" 
Get-ChildItem "./" -Recurse -Include "AZ_SQL_Full_Load_IR*.json", "SH_SQL_Full_Load_IR*.json" | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName

    #ParseOut the Name Attribute
    $jsonobject = $_ | Get-Content | ConvertFrom-Json
    $name = $jsonobject.name

    #Persist File Back
    $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_
    
    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"

    write-host $fileName -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2Pipeline -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -Force
    $body = ($jsonobject | ConvertTo-Json -compress  -Depth 100 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/pipelines/$name" 
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'

}
Write-Host "Uploading Level 3 Dependencies - Chunks" 
Get-ChildItem "./" -Filter *chunk*.json | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName

    #ParseOut the Name Attribute
    $jsonobject = $_ | Get-Content | ConvertFrom-Json
    $name = $jsonobject.name

    #Persist File Back
    $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_

    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"    

    write-host $fileName -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2Pipeline -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -Force
    $body = ($jsonobject | ConvertTo-Json -compress  -Depth 100 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/pipelines/$name" 
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'
    
}

Write-Host "Uploading Level 4 Dependencies" 
Get-ChildItem "./" -Exclude "FileForUpload.json", "Master*.json","AZ_Function_Generic.json", "OnP_SQL_Watermark_IR*.json", "AZ_SQL_Watermark_IR*.json", "*Chunk*.json", "AZ_SQL_Full_Load_IR*.json", "SH_SQL_Full_Load_IR*.json", "OnP_SQL_Full_Load_IR*.json", "SH_SQL_Watermark_IR*.json"  | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName

    #ParseOut the Name Attribute
    $jsonobject = $_ | Get-Content | ConvertFrom-Json
    $name = $jsonobject.name

    #Persist File Back
    $jsonobject | ConvertTo-Json  -Depth 100 | set-content $_

    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"

    write-host $fileName -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2Pipeline -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -Force
    $body = ($jsonobject | ConvertTo-Json -compress  -Depth 100 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/pipelines/$name" 
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'
}

Write-Host "Processing Master" 
Get-ChildItem "./" -Filter Master*.json | 
Foreach-Object {
       
    $lsName = $_.BaseName 
    $fileName = $_.FullName

    #ParseOut the Name Attribute
    $jsonobject = $_ | Get-Content | ConvertFrom-Json
    $name = $jsonobject.name

    #Make a copy of the file for upload 
    Copy-Item  -Path $fileName -Destination "FileForUpload.json"

    write-host $fileName -ForegroundColor Yellow -BackgroundColor DarkGreen
    #Set-AzDataFactoryV2Pipeline -DataFactoryName $env:AdsOpts_CD_Services_DataFactory_Name -ResourceGroupName $env:AdsOpts_CD_ResourceGroup_Name -Name $lsName -DefinitionFile $fileName -Force
    $body = ($jsonobject | ConvertTo-Json -compress  -Depth 100 | Out-String).Replace('"','\"')
    $uri = "https://management.azure.com/$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/pipelines/$name" 
    Write-Host "Uploading Master" 
    $rest = az rest --method put --uri $uri --headers '{\"Content-Type\":\"application/json\"}' --body "@FileForUpload.json" --uri-parameters 'api-version=2018-06-01'
    
}

Remove-Item -Path "FileForUpload.json" -ErrorAction SilentlyContinue

#Change Back to Workflows dir
Set-Location $CurrentPath