    BEGIN 
    Select * into #TempTTM from ( VALUES(-6, N'DLL', N'Synapse_SQLPool_Start_Stop', N'N/A', N'Not-Applicable', N'Azure Synapse', N'Not-Applicable', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "SQLPoolName": {
         "options": {
            "infoText": "Use this field to define the name of the Synapse SQL Pool you are wanting to manipulate within your workspace.",
            "inputAttributes": {
               "placeholder": "TestPool"
            }
         },
         "type": "string"
      },
      "SQLPoolOperation": {
         "enum": [
            "Start",
            "Pause"
         ],
         "type": "string"
      },
      "Source": {
         "options": {
            "hidden": true
         },
         "properties": {
            "Type": {
               "default": "Not-Applicable",
               "enum": [
                  "Not-Applicable"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "options": {
            "hidden": true
         },
         "properties": {
            "Type": {
               "default": "Not-Applicable",
               "enum": [
                  "Not-Applicable"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "SQLPoolName",
      "SQLPoolOperation"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}')    ) a([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema])
    
    
    Update [dbo].[TaskTypeMapping]
    Set 
    MappingName = ttm2.MappingName,
    TaskMasterJsonSchema = ttm2.TaskMasterJsonSchema,
    TaskInstanceJsonSchema = ttm2.TaskInstanceJsonSchema
    from 
    [dbo].[TaskTypeMapping] ttm  
    inner join #TempTTM ttm2 on 
        ttm2.TaskTypeId = ttm.TaskTypeId 
        and ttm2.MappingType = ttm.MappingType
        and ttm2.SourceSystemType = ttm.SourceSystemType 
        and ttm2.SourceType = ttm.SourceType 
        and ttm2.TargetSystemType = ttm.TargetSystemType 
        and ttm2.TargetType = ttm.TargetType 

    Insert into 
    [dbo].[TaskTypeMapping]
    ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema])
    Select ttm2.* 
    from [dbo].[TaskTypeMapping] ttm  
    right join #TempTTM ttm2 on 
        ttm2.TaskTypeId = ttm.TaskTypeId 
        and ttm2.MappingType = ttm.MappingType
        and ttm2.SourceSystemType = ttm.SourceSystemType 
        and ttm2.SourceType = ttm.SourceType 
        and ttm2.TargetSystemType = ttm.TargetSystemType 
        and ttm2.TargetType = ttm.TargetType 
    where ttm.TaskTypeMappingId is null

    END 
