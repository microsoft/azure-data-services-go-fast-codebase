using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class TaskGroup
    {
        public TaskGroup()
        {
            TaskGroupConcurrency = 10;
            TaskGroupJson = @"{}";
        }
        public virtual List<TaskMaster> TaskMasters { get; set; }
        public virtual SubjectArea SubjectArea { get; set; }
    }
}
