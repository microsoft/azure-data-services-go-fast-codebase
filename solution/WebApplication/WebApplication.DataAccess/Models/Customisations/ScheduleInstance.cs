using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class ScheduleInstance
    { 
        public virtual ScheduleMaster ScheduleMaster { get; set; }

        public virtual List<TaskInstance> TaskInstances { get; set; }
    }
}
