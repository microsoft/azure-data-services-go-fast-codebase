function(GFPIR="IRA") 
{
  "source": {
      "type": "ExcelSource",
      "storeSettings": {
          "type": "AzureBlobFSReadSettings",
          "recursive": true
      }
  },
  "sink": {
      "type": "DelimitedTextSink",
      "storeSettings": {
          "type": "AzureBlobFSWriteSettings"
      },
      "formatSettings": {
          "type": "DelimitedTextWriteSettings",
          "quoteAllText": true,
          "fileExtension": ".txt"
      }
  },
  "enableStaging": false,
  "parallelCopies": {
      "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
      "type": "Expression"
  }
}

