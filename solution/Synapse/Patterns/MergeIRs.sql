            Merge dbo.IntegrationRuntime Tgt
            using (
            Select * from OPENJSON('[
{
  "is_azure": true,
  "is_managed_vnet": true,
  "engine_id": 2,
  "name": "Azure-Integration-Runtime",
  "short_name": "Azure",
  "valid_pipeline_patterns": [
    {
      "Folder": "*",
      "SourceFormat": "*",
      "SourceType": "*",
      "TargetFormat": "*",
      "TargetType": "*",
      "TaskTypeId": "*"
    }
  ],
  "valid_source_systems": [
    "*"
  ]
}
]') WITH 
            (
                name varchar(200), 
                short_name varchar(20),
                engine_id int, 
                is_azure bit, 
                is_managed_vnet bit     
            )
            ) Src on Src.short_name = tgt.IntegrationRuntimeName AND Src.engine_id = tgt.EngineId
            when NOT matched by TARGET then insert
            (IntegrationRuntimeName, EngineId, ActiveYN)
            VALUES (Src.short_name,2,1);


            drop table if exists #tempIntegrationRuntimeMapping 
            Select ir.IntegrationRuntimeId, a.short_name IntegrationRuntimeName, a.engine_id EngineId, c.[value] SystemId
            into #tempIntegrationRuntimeMapping
            from 
            (
            Select IR.*, Patterns.[Value] from OPENJSON('[{
  "is_azure": true,
  "is_managed_vnet": true,
  "engine_id": 2,
  "name": "Azure-Integration-Runtime",
  "short_name": "Azure",
  "valid_pipeline_patterns": [
    {
      "Folder": "*",
      "SourceFormat": "*",
      "SourceType": "*",
      "TargetFormat": "*",
      "TargetType": "*",
      "TaskTypeId": "*"
    }
  ],
  "valid_source_systems": [
    "*"
  ]
}]') A 
           CROSS APPLY OPENJSON(A.[value]) Patterns 
           CROSS APPLY OPENJSON(A.[value]) with (short_name varchar(max), engine_id int) IR 
           where Patterns.[key] = 'valid_source_systems'
           ) A
           OUTER APPLY OPENJSON(A.[Value])  C
           join 
           dbo.IntegrationRuntime ir on ir.IntegrationRuntimeName = a.short_name AND ir.EngineId = a.engine_id
           
           drop table if exists #tempIntegrationRuntimeMapping2
           Select * into #tempIntegrationRuntimeMapping2
           from 
           (
           select a.IntegrationRuntimeId, a.IntegrationRuntimeName, a.EngineId, b.SystemId from #tempIntegrationRuntimeMapping  a
           cross join [dbo].[SourceAndTargetSystems] b 
           where a.SystemId = '*'
           union 
           select a.IntegrationRuntimeId, a.IntegrationRuntimeName, a.EngineId, a.SystemId from #tempIntegrationRuntimeMapping  a
           where a.SystemId != '*'
           ) a
                    
           Merge dbo.IntegrationRuntimeMapping tgt
           using #tempIntegrationRuntimeMapping2 src on 
           tgt.IntegrationRuntimeName = src.IntegrationRuntimeName and tgt.SystemId = src.SystemId and tgt.EngineId = src.EngineId
           when not matched by target then 
           insert 
           ([IntegrationRuntimeId], [IntegrationRuntimeName], [SystemId], [ActiveYN], [EngineId])
           values 
           (src.IntegrationRuntimeId, src.IntegrationRuntimeName, cast(src.SystemId as bigint), 1, src.EngineId);            

           
