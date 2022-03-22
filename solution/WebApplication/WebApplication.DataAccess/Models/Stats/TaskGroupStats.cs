using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication.Models
{
    [Table(nameof(TaskGroupStats), Schema = "WebApp")]
    public partial class TaskGroupStats
    {
        public long TaskGroupId { get; set; }
        public string TaskGroupName { get; set; }
        public int? Tasks { get; set; }
        public int? TaskInstances { get; set; }
        public int? Schedules { get; set; }
        public int? ScheduleInstances { get; set; }
        public int? Executions { get; set; }
        public double? EstimatedCost { get; set; }
        public long? RowsCopied { get; set; }
        public long? DataRead { get; set; }
        public long? DataWritten { get; set; }
    }
}
