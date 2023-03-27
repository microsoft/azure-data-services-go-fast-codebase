    BEGIN 
    Select * into #TempTTM from ( VALUES(-13, N'DLL', N'Execute_VM_Command', N'VM-N/A', N'Not-Applicable', N'VM-N/A', N'dbt', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "ExecutionPath": {
         "options": {
            "infoText": "(required) Use this field to define the FULL path where you wish to execute the command.",
            "inputAttributes": {
               "placeholder": "/home/testuser"
            }
         },
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
         "properties": {
            "ExecutionCommand": {
               "enum": [
                  "dbt build",
                  "Test enum"
               ],
               "options": {
                  "infoText": "(required) Use this field to select the command you wish to execute."
               },
               "type": "string"
            },
            "ExecutionParameters": {
               "options": {
                  "infoText": "(optional) Use this field to define any parameters / flags that go along with your command. NOTE: Certain characters not expected will be stripped from this string",
                  "inputAttributes": {
                     "placeholder": "TestPool"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "dbt"
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
      "ExecutionPath"
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
