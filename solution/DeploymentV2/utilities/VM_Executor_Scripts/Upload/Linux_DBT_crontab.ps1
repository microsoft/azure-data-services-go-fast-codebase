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
    $file = $files[0]
    try {
        #set up
        $filePath = $file.name
        $utilPath = '/home/adminuser/util/config.json'
        $localDest = "temp/" + $filePath
        #get util json
        az storage fs file download -p $filePath -d $localDest -f $container --account-name $accountName --auth-mode login
        $util = Get-Content -Path $utilPath | ConvertFrom-Json
        $keyVaultName = $util.KeyVaultName
        $keySecretName = $util.KeySecretName
        $saltSecretName = $util.SaltSecretName
        #get input text file
        $encryptedText = Get-Content $localDest

        # Decrypt text file
        #get kv details from static file
        $result = az keyvault secret show --vault-name $keyVaultName -n $saltSecretName | ConvertFrom-Json
        $iv = $result.value
        $result = az keyvault secret show --vault-name $keyVaultName -n $keySecretName | ConvertFrom-Json
        $key = $result.value.PadRight(16, [char]0)

        $data = [Convert]::FromBase64String($encryptedText)

        $aes = [System.Security.Cryptography.Aes]::Create()
        $aes.Key = [System.Convert]::FromBase64String($key)
        $aes.IV  = [System.Convert]::FromBase64String($iv)
        $utf8 = [System.Text.Encoding]::Utf8
        $dec = $aes.CreateDecryptor()
        $result = $dec.TransformFinalBlock($data, 0, $data.Length)
        $resultStr = $utf8.GetString($result)
        $dec.Dispose()

        $object = $resultStr | ConvertFrom-Json
        #append date
        $object.InProgressCreatedUTC = [DateTime]::UtcNow.ToString('dd/MM/yyyy HH:mm:ss tt')
        #upload to 'in_progress' folder / delete from input / delete from temp folder
        $json = $object | ConvertTo-Json -depth 100 | Out-File $localDest
        $pathTemp = $inProgressPath + $object.ExecutionUid + ".json"
        $output = az storage fs file upload --source $localDest -p $pathTemp -f $container --account-name $accountName --auth-mode login
        #delete from inputs
        $delete = az storage fs file delete -p $filePath -f $container --account-name $accountName --auth-mode login --yes
        Remove-Item $localDest
        #start execution (dbt command) - if statements to work out command - ensure it is a specific string
        cd $object.ExecutionPath
        if($object.ExecutionCommand -eq 'dbt build') 
        {
            #below is a placeholder that i am using for now - will replace with proper commands soon
            #Invoke-Expression $command #$possible parameters
            $command = '{"object": "' + $object.ExecutionInput + '"}' | ConvertFrom-Json #temp command until dbt part in
            $object.ExecutionOutput = $command

        }
        $object.OutputCreatedUTC = [DateTime]::UtcNow.ToString('dd/MM/yyyy HH:mm:ss tt')
        #cd back to root
        cd /home/adminuser
        Remove-Item $localDest
        $json = $object | ConvertTo-Json -depth 100 | Out-File $localDest
        #delete from in_progress
        $delete = az storage fs file delete -p $pathTemp -f $container --account-name $accountName --auth-mode login --yes
        #upload to output
        $pathTemp = $outputPath + $object.ExecutionUid + ".json"
        $output = az storage fs file upload --source $localDest -p $pathTemp -f $container --account-name $accountName --overwrite --auth-mode login
    }
    catch {
        $object = [PSCustomObject]@{
            ErrorOutput = $_.ScriptStackTrace
        }
        $filePath = $file.name.replace('.txt','.json')
        $localDest = "temp/" + $filePath
        $json = $object | ConvertTo-Json -depth 100 | Out-File $localDest
        $fileNameTrim = $filePath.Replace("input/","")
        $pathTemp = $outputPath + $fileNameTrim
        $output = az storage fs file upload --source $localDest -p $pathTemp -f $container --account-name $accountName --overwrite --auth-mode login
        $pathTemp = $file.name
        $delete = az storage fs file delete -p $pathTemp -f $container --account-name $accountName --auth-mode login --yes

    }

    
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

