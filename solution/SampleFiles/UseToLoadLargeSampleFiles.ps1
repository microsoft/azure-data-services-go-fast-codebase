<# wget https://aka.ms/downloadazcopy-v10-linux
tar -xvf downloadazcopy-v10-linux

# Move AzCopy
sudo rm -f /usr/bin/azcopy
sudo cp ./azcopy_linux_amd64_*/azcopy /usr/bin/
sudo chmod 755 /usr/bin/azcopy

# Clean the kitchen
rm -f downloadazcopy-v10-linux
rm -rf ./azcopy_linux_amd64_*/ #>

<#

    Use this to load large sample files to an Azure Storage Account
    Run in Cloud Shell to save on transfer time and fees
#>

#https://nytaxiblob.blob.core.windows.net/2013/Date

$samples = "https://jrambosampledata.blob.core.windows.net/sampledata/"
$filemask = "yellow_tripdata_2010-"
$i=@(
"01",
"02",
"03",
"04",
"05",
"06",
"07",
"08",
"09",
"10",
"11",
"12"
)

$sassig = "###"

#azcopy login

$i | foreach-object {
    $source = "https://s3.amazonaws.com/nyc-tlc/trip+data/" +  $filemask + $_ + ".csv"
    $target = $filemask + $_ + ".csv"
    #$source
    #$target
    curl $source >> $target
    $samplesdest = $samples + $target + $sassig
    azcopy copy $target $samplesdest
}
