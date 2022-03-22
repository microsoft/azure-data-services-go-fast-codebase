using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class TaskInstance
    {
        public TaskExecutionStatus LastExecutionStatus { get; set; }
        public virtual TaskMaster TaskMaster { get; set; }
        public virtual ScheduleInstance ScheduleInstance { get; set; }
        public virtual List<TaskInstanceExecution> TaskInstanceExecutions { get; set; }

        public string Description { get => $"{TaskMaster?.TaskMasterName} - {ScheduleInstance?.ScheduleInstanceId}"; }
    }
    
}