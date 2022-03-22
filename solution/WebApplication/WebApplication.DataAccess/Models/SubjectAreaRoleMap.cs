using System;

namespace WebApplication.Models
{
    public partial class SubjectAreaRoleMap
    {
        public int SubjectAreaId { get; set; }
        public Guid AadGroupUid { get; set; }
        public string ApplicationRoleName { get; set; }
        public DateTime ExpiryDate { get; set; }
        public bool ActiveYn { get; set; }
        public string UpdatedBy { get; set; }
    }
}
