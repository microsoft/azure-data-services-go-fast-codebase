function (SinkType="AzureBlobStorage")
if (SinkType == "AzureBlobStorage") then
{
    "type": "AzureBlobStorageWriteSettings",
    "copyBehavior": "PreserveHierarchy"
}
else if (SinkType == "AzureBlobFS") then
{
    "type": "AzureBlobFSWriteSettings",
    "copyBehavior": "PreserveHierarchy"
}