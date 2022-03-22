namespace WebApplication.Models
{
    public partial class SubjectAreaSystemMap
    {
        public int SubjectAreaId { get; set; }
        public long SystemId { get; set; }
        public byte MappingType { get; set; }
        public string AllowedSchemas { get; set; }
        public bool? ActiveYn { get; set; }
        public int? SubjectAreaFormId { get; set; }
        public string DefaultTargetSchema { get; set; }
        public string UpdatedBy { get; set; }
    }
}
