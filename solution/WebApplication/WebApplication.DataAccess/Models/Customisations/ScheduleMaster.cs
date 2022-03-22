using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class ScheduleMaster
    {
        public virtual List<TaskMaster> TaskMasters { get; set; }
        public virtual List<ScheduleInstance> ScheduleInstances { get; set; }
    }
}
