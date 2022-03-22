using System;

namespace WebApplication.Models
{
    public partial class Execution
    {
        public Guid ExecutionUid { get; set; }
        public DateTimeOffset? StartDateTime { get; set; }
        public DateTimeOffset? EndDateTime { get; set; }
    }
}
