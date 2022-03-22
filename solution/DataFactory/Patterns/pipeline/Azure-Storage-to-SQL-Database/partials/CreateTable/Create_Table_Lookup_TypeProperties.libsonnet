local basetemplate = function(ReferenceName = "", DataFactorySourceType="", Staging=false)
{
    local TargetPrefixForActivityName = if (Staging==true) then "Staging" else "Target",
    local TargetPrefixForParameters = if (Staging==true) then "Staging" else "",    
    "source": {
      "type": DataFactorySourceType,
      "sqlReaderQuery": {
          "value": "@activity('AF Get SQL Create Statement "+TargetPrefixForActivityName+"').output.CreateStatement",
          "type": "Expression"
      },
      "queryTimeout": "02:00:00",
      "partitionOption": "None"
    },
    "dataset": {
         "referenceName":   ReferenceName,
        "type": "DatasetReference",
        "parameters": {
            "Schema": {
                "value": "@pipeline().parameters.TaskObject.Target."+TargetPrefixForParameters+"TableSchema",
                "type": "Expression"
            },
            "Table": {
                "value": "@pipeline().parameters.TaskObject.Target."+TargetPrefixForParameters+"TableName",
                "type": "Expression"
            },
            "Server": {
                "value": "@pipeline().parameters.TaskObject.Target.System.SystemServer",
                "type": "Expression"
            },
            "Database": {
                "value": "@pipeline().parameters.TaskObject.Target.System.Database",
                "type": "Expression"
            }
        }
    },
     "firstRowOnly": false
};

function(GenerateArm="false",GFPIR="Azure", TargetType="AzureSqlDWTable", Staging=true)
local referenceName =   if (GenerateArm=="false") 
                        then "GDS_"+TargetType+"_NA_"+GFPIR
                        else "[concat('GDS_"+TargetType+"_NA_', parameters('integrationRuntimeShortName'))]";

local TargetTypes = {
    "AzureSqlTable": basetemplate(referenceName,"AzureSqlSource",Staging),
    "AzureSqlDWTable":basetemplate(referenceName,"SqlDWSource",Staging)
};

TargetTypes[TargetType]