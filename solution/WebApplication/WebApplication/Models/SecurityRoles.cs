using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Models
{
    public static class SecurityRoles
    {
        public static class Application
        {
            public const string Administrator = "Administrator";
            public const string Analyst = "Analyst";
            public const string Reader = "Reader";
            public const string DataAdmin = "DataAdministrator";
            public const string PipelineAdmin = "PipelineAdministrator";
            public const string PlatformManager = "PlatformManager";
        }

        public static class SubjectArea
        {
            public const string Reader = "SubjectAreaReader";
            public const string Custodian = "SubjectAreaCustodian";
            public const string Steward = "SubjectAreaSteward";
            public const string Owner = "SubjectAreaOwner";
        }
    }
}
