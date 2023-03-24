#cd to home as required
cd /home/adminuser
#login using system identity
az login --identity
$accounts = az storage account list | ConvertFrom-Json
$account = $accounts[0]
$accountName = $account.name
#static container and directories
$container = "dbt"
$inputPath = "input/"
$inProgressPath = "in_progress/" 
$outputPath = "output/"
$files =  az storage fs file list --path $inputPath -f $container --account-name $accountName --auth-mode login | ConvertFrom-Json
#if we have files in the input directory -> we want to grab the first one
#note: this may be changed
if($files.length -gt 0)
{
    #download file
    $file = $files[0]
    $filePath = $file.name
    $localDest = "temp/" + $filePath
    az storage fs file download -p $filePath -d $localDest -f $container --account-name $accountName --auth-mode login
    #append date
    $object = Get-Content $localDest | ConvertFrom-Json
    $object.InProgressCreatedUTC = [DateTime]::UtcNow.ToString('dd/MM/yyyy HH:mm:ss tt')
    #upload to 'in_progress' folder / delete from input / delete from temp folder
    $json = $object | ConvertTo-Json -depth 100 | Out-File $localDest
    $pathTemp = $inProgressPath + $object.ExecutionUid + ".json"
    $output = az storage fs file upload --source $localDest -p $pathTemp -f $container --account-name $accountName --auth-mode login
    #delete from inputs
    $delete = az storage fs file delete -p $filePath -f $container --account-name $accountName --auth-mode login --yes
    Remove-Item $localDest
    #start execution (dbt command)
    cd $object.ExecutionPath
    #Invoke-Expression $command #$possible parameters
    $command = '{"object": "' + $object.ExecutionInput + '"}' | ConvertFrom-Json #temp command until dbt part in
    $object.OutputCreatedUTC = [DateTime]::UtcNow.ToString('dd/MM/yyyy HH:mm:ss tt')
    $object.ExecutionOutput = $command
    $object
    #cd back to root
    cd /home/adminuser
    $json = $object | ConvertTo-Json -depth 100 | Out-File $localDest
    #delete from in_progress
    $delete = az storage fs file delete -p $pathTemp -f $container --account-name $accountName --auth-mode login --yes
    #upload to output
    $pathTemp = $outputPath + $object.ExecutionUid + ".json"
    $output = az storage fs file upload --source $localDest -p $pathTemp -f $container --account-name $accountName --overwrite --auth-mode login
}

#may want mail service 
# sudo crontab -e 
# sudo crontab -l #to check
# */5 * * * * pwsh -executionpolicy bypass -File "/home/adminuser/scripts/Linux_DBT_crontab.ps1"
# sudo service cron start
# $path = "Linux_DBT_crontab.ps1"
# $localPath = "/home/adminuser/scripts/Linux_DBT_crontab.ps1"
# $container = "dbt"
# $accountName = 
# az storage fs file download -p $path -d $localPath -f $container --account-name $accountName --auth-mode login



#sudo service cron stop


#location -> /var/spool/cron/crontabs/adminuser