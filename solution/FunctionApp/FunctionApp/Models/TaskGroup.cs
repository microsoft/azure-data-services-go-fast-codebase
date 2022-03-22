/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

namespace FunctionApp.Models
{
    public class TaskGroup
    {
        public long TaskGroupId { get; set; }
        public string TaskGroupName { get; set; }
        public int TaskGroupPriority { get; set; }
        public short TaskGroupConcurrency { get; set; }
        public string TaskGroupJson { get; set; }
        public bool ActiveYn { get; set; }
        public short TaskCount { get; set; }
        public short ConcurrencySlotsAllocated { get; set; }
        public short TasksUnAllocated { get; set; }
    }
}
