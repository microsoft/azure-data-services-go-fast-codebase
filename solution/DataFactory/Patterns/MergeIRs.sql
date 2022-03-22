            Merge dbo.IntegrationRuntime Tgt
            using (
            Select * from OPENJSON('[
  {
    "is_azure": true,
    "is_managed_vnet": true,
    "name": "Azure-Integration-Runtime",
    "short_name": "Azure"
  },
  {
    "is_azure": false,
    "is_managed_vnet": false,
    "name": "Onprem-Integration-Runtime",
    "short_name": "OnPrem"
  }
]') WITH 
            (
                name varchar(200), 
                short_name varchar(20), 
                is_azure bit, 
                is_managed_vnet bit     
            )
            ) Src on Src.short_name = tgt.IntegrationRuntimeName 
            when NOT matched by TARGET then insert
            (IntegrationRuntimeName, EngineId, ActiveYN)
            VALUES (Src.short_name,1,1);
