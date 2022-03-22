/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Linq;
using FunctionApp.DataAccess;

namespace FunctionApp.Models
{
    public class EngineJsonSchemasProvider
    {
        private readonly List<EngineJsonSchema> _jsonSchemas;

        public EngineJsonSchemasProvider(TaskMetaDataDatabase taskMetaDataDatabase)
        {
            _jsonSchemas = taskMetaDataDatabase.GetSqlConnection().QueryWithRetry<EngineJsonSchema>("select * from [dbo].[ExecutionEngine_JsonSchema]").ToList();
        }
        
        public EngineJsonSchema GetBySystemType(string SystemType)
        {
            EngineJsonSchema ret;
            if (_jsonSchemas.Any(x => x.SystemType == SystemType))
            {
                ret = _jsonSchemas.First(x => x.SystemType == SystemType);
            }
            else
            {
                throw (new Exception("Failed to find ExecutionEngine_JsonSchema record for SystemType: " + SystemType));
            }

            return ret;
        }
    }
}


