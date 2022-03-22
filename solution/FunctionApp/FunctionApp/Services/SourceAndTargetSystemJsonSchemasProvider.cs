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
    public class SourceAndTargetSystemJsonSchemasProvider
    {
        private readonly List<SourceAndTargetSystemJsonSchema> _jsonSchemas;

        public SourceAndTargetSystemJsonSchemasProvider(TaskMetaDataDatabase taskMetaDataDatabase)
        {
            _jsonSchemas = taskMetaDataDatabase.GetSqlConnection().QueryWithRetry<SourceAndTargetSystemJsonSchema>("select * from [dbo].[SourceAndTargetSystems_JsonSchema]").ToList();
        }
        
        public SourceAndTargetSystemJsonSchema GetBySystemType(string SystemType)
        {
            SourceAndTargetSystemJsonSchema ret;
            if (_jsonSchemas.Any(x => x.SystemType == SystemType))
            {
                ret = _jsonSchemas.First(x => x.SystemType == SystemType);
            }
            else
            {
                throw (new Exception("Failed to find SourceAndTargetSystems_JsonSchema record for SystemType: " + SystemType));
            }

            return ret;
        }
    }
}


