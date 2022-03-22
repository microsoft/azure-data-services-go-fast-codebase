using System;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public class IntegrationRuntime
    {
        public int IntegrationRuntimeId { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Name")]
        public string IntegrationRuntimeName { get; set; }
        public long EngineId { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }

        public virtual ExecutionEngine ExecutionEngine { get; set; }
    }
}
