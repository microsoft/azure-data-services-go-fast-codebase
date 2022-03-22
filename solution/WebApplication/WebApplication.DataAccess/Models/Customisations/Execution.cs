using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class Execution
    {
        public virtual List<TaskInstanceExecution> TaskInstanceExecutions { get; set; }


    }
}
