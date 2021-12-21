
$pathbase = "./../../SampleFiles/"   
$files = @("yellow_tripdata_2017-03.xlsx","yellow_tripdata_2017-03.csv") 

$files | ForEach-Object -Parallel {
    
    $result = az storage blob upload --file $using:pathbase/$_ --container-name "datalakeraw" --name samples/$_ --account-name $env:AdsOpts_CD_Services_Storage_ADLS_Name
    $result = az storage blob upload --file $using:pathbase/$_ --container-name "datalakeraw" --name samples/$_ --account-name $env:AdsOpts_CD_Services_Storage_Blob_Name
}

