/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


insert into [dbo].[SourceAndTargetSystems_JsonSchema]
Select SystemType,JsonSchema  from 
(
Select 'ADLS' as SystemType, '{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Container": {      "type": "string"    }  },  "required": [    "Container"  ]}' as JsonSchema
union all
Select 'Azure Blob' as SystemType, '{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Container": {      "type": "string"    }  },  "required": [    "Container"  ]}' as JsonSchema
union all
Select 'Azure SQL' as SystemType, '{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Database": {      "type": "string"    }  },  "required": [    "Database"  ]}' as JsonSchema
union all
Select 'AzureVM' as SystemType, '{     "$schema": "http://json-schema.org/draft-04/schema#",     "type": "object",     "properties": {         "SubscriptionUid": {             "type": "string"         },         "VMname": {           "type": "string"       },       "ResourceGroup": {         "type": "string"     }     },     "required": [         "SubscriptionUid",         "VMname",         "ResourceGroup"      ] }' as JsonSchema
union all
Select 'SendGrid' as SystemType, '{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "SenderEmail": {      "type": "string"    },    "SenderDescription": {      "type": "string"    }  },  "required": [    "SenderEmail",    "SenderDescription"  ]}' as JsonSchema
union all
Select 'SQL Server' as SystemType, '{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Database": {      "type": "string"    }  },  "required": [    "Database"  ]}' as JsonSchema
) a