using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class TaskType
    {
       public TaskExecutionTypeEnum TaskExecutionType { get; set; }
       public virtual List<TaskMaster> TaskMasters { get; set; }
       public virtual List<TaskTypeMapping> TaskTypeMappings { get; set; }

    }
    
}
