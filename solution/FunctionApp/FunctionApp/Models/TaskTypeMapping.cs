/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;

namespace FunctionApp.Models
{
    public class TaskTypeMapping
    {
        public Int64 TaskTypeId          {get; set;}
        public string MappingType         {get; set;}
        public string MappingName         {get; set;}
        public string SourceSystemType    {get; set;}
        public string SourceType          {get; set;}
        public string TargetSystemType    {get; set;}
        public string TargetType          {get; set;}
        public string TaskDatafactoryIr { get; set; }
        public string TaskMasterJsonSchema { get; set; }
        public string TaskInstanceJsonSchema { get; set; }
    }
}
