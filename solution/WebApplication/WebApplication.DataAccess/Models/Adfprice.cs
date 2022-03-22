using System;

namespace WebApplication.Models
{
    public partial class Adfprice
    {
        public long AdfpriceId { get; set; }
        public string Type { get; set; }
        public string Unit { get; set; }
        public decimal Price { get; set; }
        public string Currency { get; set; }
        public string IntegrationRunTime { get; set; }
        public string Description { get; set; }
        public DateTimeOffset UpdatedOn { get; set; }
    }
}
