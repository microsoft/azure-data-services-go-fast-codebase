using System;
using System.Collections.Generic;
using System.Text;

namespace WebApplication.Models
{
    public partial class ExecutionEngine
    {        
         public virtual List<TaskMaster> TaskMasters { get; set; }
         public virtual List<IntegrationRuntime> IntegrationRuntime { get; set; }

    }
}
