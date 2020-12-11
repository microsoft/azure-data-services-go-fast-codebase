using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Models.Customisations.WizardReference
{
    public class WizardEnums 
    {
        public enum SuppressionRuleOptions
        {
            Applied = 0,
            NotApplied = 1,
            NA = 2
        }

        public enum PersonalDeIdentified
        {
            Personal = 0,
            DeIdentified = 1
        }

        public enum FormOfData
        {
            Statistics = 0,
            Text = 1
        }

        public enum InformationLevel
        {
            MicroData = 0,
            Aggregated = 1,
            DirectIdentifier = 2,
            IndirectIdentifiers = 3,
            Targets = 4
        }

        public enum DatasetProperties
        {
            Age = 0,
            Gender = 1,
            Quality = 2,
            IndigenousStats = 3,
            Location = 4,
            NA = 5
        }

        public enum OrganisationalRoles // placeholder values
        {
            RoleA = 0,
            RoleB = 1,
            RoleC = 2
        }

        public enum SystemRoles // placeholder values
        {
            RoleA = 0,
            RoleB = 1,
            RoleC = 2
        }

        public enum SpecificationOutcomes
        {
            ReduceDataComplexity = 0,
            ExcludeSensitiveVariable = 1,
            ExcludeDetailedVariables = 2
        }

        public enum EnvironmentReconfigurationOptions
        {
            SpecifyPeopleAccess = 0,
            SpecifyRequisiteSecurityLevel = 1,
            AllowAccessOnlyWithinOwnSecureEnvironment = 2,
            SpecifyAllAnalyticsBeCheckedBeforePublish = 3,
            MakeUseOfDataAgreements = 4
        }

        public enum DataModificationOptions
        {
            DeIdentify = 0,
            Suppress = 1,
            Anonymise = 2,
            Aggregate = 3,
            DeleteCertainFields = 4
        }

        public enum DataBreachImpactManagementOptions
        {
            AdditionalAccessControl = 0,
            RemoveIdentifiableData = 1,
            DSAOnDataUsage = 2,
            DataSuppressionUsed = 3,
            Other = 4 // text input
        }

        public enum StakeholderAssuranceDataProtection
        {
            DSA = 0,
            XYZ = 1,
            ContactWhenRiskProfileChanges = 2,
            placeholder = 3,
            placeholder2 = 4
        }

        public enum DataBreachPlanOptions
        {
            RobustAuditTrail = 0,
            CrisisManagementPolicy = 1,
            NotifyDataBreachProcess = 2,
            TrainedStaff = 3,
            Other = 4
        }

    }
}
