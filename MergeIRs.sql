            Merge dbo.IntegrationRuntime Tgt
            using (
            Select * from OPENJSON('null') WITH 
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
