using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Models.Customisations.WizardReference;
using static WebApplication.Models.Customisations.WizardReference.WizardEnums;

namespace WebApplication.Models.Customisations
{
    public class PIAWizardModel
    {
        public int Id { get; set; }

        #region Introduction

        [Display(Name = "1. Are you authorised to use this data by the data subjects?")]
        public bool AuthorisedByDataSubjects { get; set; }

        [Display(Name = "2. Have the appropriate Data Agreements have been signed?")]
        public bool DataAgreementsSigned { get; set; }

        [Display(Name = "3. Do you understand that the Metadata captured will be used to search and obtain access to this data?")]
        public bool UnderstandMetadata { get; set; }

        [Display(Name = "4. Do you accept responsibility for this PIA process and the truthfulness of the responses?")]
        public bool AcceptResponsibility { get; set; }

        // dropdown for all phns
        [Display(Name = "5. Which PHN does the Dataset belong to?")]
        public SubjectArea BelongingDataset { get; set; }

        // dropdown of all extraction tools
        [Display(Name = "6. Which system is the dataset being taken from?")]
        public TaskGroup OwningSystem { get; set; }

        // screen change trigger
        // 4 fields - first 2 are auto generated based on previous 2 (5. and 6.)
        [Display(Name = "7. PHN_System_Purpose_Version E.g. WAPHA_PATCAT_GP_V0.3")]
        public string SystemPurposeVersion { get; set; }

        #endregion

        #region Understand your legal responsibility

        [Display(Name = "8. Is the data personal information or de-identified data?")]
        public PersonalDeIdentified DataPersonalOrDeIdentified { get; set; }

        [Display(Name = "9. Suppress both numerator and denominator if either or both of these in a row contain number <10 (to prevent back calculation), but don’t suppress the proportion")]
        public SuppressionRuleOptions SuppressionRuleOne { get; set; }

        [Display(Name = "10. If you suppress numerator and denominator only in one row, please supress the numerator and denominator in the adjacent row for that QIM (without supressing the proportion)")]
        public SuppressionRuleOptions SuppressionRuleTwo { get; set; }

        [Display(Name = "11. If you find zeros in the rows for ‘0 – 4’ and/or ‘5 -14 Yr.’ age disaggregation for QIM 05, please merge the data for these two age groups to ‘<15 yrs.’ to see if there is any valid number (but rule 1 and 2 applies) ")]
        public SuppressionRuleOptions SuppressionRuleThree { get; set; }

        [Display(Name = "12. If you find zeros for Sex X (Indeterminate/Intersex/Unspecified/Not stated/Inadequately described) for any QIM, please merge all age groups and Indigenous status for Sex X to see if there is any valid number (again rule 1 and 2 applies)")]
        public SuppressionRuleOptions SuppressionRuleFour { get; set; }

        // screen change trigger
        [Display(Name = "13.In relation to \\“Do privacy obligations still apply to de-identified data?\\”, have you identified and documented how the data custodian should manage such a risk, while still using de-identified data in the ways that it is legally permitted to use it?")]
        public bool IdentifiedDataCustodianManagedRisk { get; set; }

        #endregion

        #region Data Metadata

        [Display(Name = "14. What form are your data in?")]
        public FormOfData DataForm { get; set; }

        // Note: spec is unclear. I have combined the info levels into 1 enum for now

        [Display(Name = "15. What level of information about the population do the data provide?")]
        public InformationLevel InfoLevelOfData { get; set; }

        [Display(Name = "16. What are the top-3 properties of the dataset?")]
        public DatasetProperties TopThreePropsOfData { get; set; }

        [Display(Name = "17. Is the data quality high?")]
        public bool IsDataQualityLevelHigh { get; set; }

        [Display(Name = "18. Is the data about a vulnerable population?")]
        public bool IsDataAboutVulnerablePopulation { get; set; }

        [Display(Name = "19. Is the data new, collated in past year?")]
        public bool IsDataCollatedInPastYear { get; set; }

        [Display(Name = "20. Is the data hierarchical in nature?")]
        public bool IsDataHierarchical { get; set; }

        // screen change trigger
        [Display(Name = "21. Is the data Time-stamped?")]
        public bool IsDataTimeStamped { get; set; }

        #endregion

        #region Data subjects

        [Display(Name = "22. Data Owner (one only)")] 
        public OrganisationalRoles DataOwnerOrg { get; set; }
        public SystemRoles DataOwnerSys { get; set; }

        [Display(Name = "23. Data Custodian (one only)")] // only 1
        public OrganisationalRoles DataCustodianOrg { get; set; }
        public SystemRoles DataCustodianSys { get; set; }

        [Display(Name = "24. Data Steward (can have multiple)")] // can have multiple, dynamically add more?
        public OrganisationalRoles DataStewardOrg { get; set; }
        public SystemRoles DataStewardSys { get; set; }

        // Organisation Role RACI / System Role Access
        // reference table goes here -- in what format, to be determined

        #endregion

        #region Meet your ethical obligations

        [Display(Name = "25. Have you sought consent from data subjects for what I intend to do with their data once de-identified?")]
        public bool RespectDataAssurances { get; set; }

        [Display(Name = "26. Have you provided transparency to your data subjects how you reuse data with a description of your rationale?")]
        public bool HasProvidedTransparency { get; set; }

        [Display(Name = "27. Have you obtained your data subjects’ views on your proposed data sharing/release activities and addressing their concerns?")]
        public bool HasObtainedSubjectsViews { get; set; }

        [Display(Name = "28. Have you formalised in principles, policies, and procedures for data security, handling, management and storage, data breach notifications, and share/release?")]
        public bool HasFormalisedPrinciples { get; set; }

        #endregion

        #region Identify the processes you will need to go through

        // can include multiple selections?
        [Display(Name = "29. Have you incorporated a top-level assessment to produce an initial specification? Outcomes are:")]
        public SpecificationOutcomes TopLevelAssessment { get; set; }

        [Display(Name = "30. Analysis to establish relevant plausible scenarios for your data situation. When you undertake a scenario analysis, you are essentially considering the how, who and why of a potential data breach.Explain ? ")]
        public string AnalysisExplanation { get; set; }
        
        [Display(Name = "31. Data Analytical approaches considered:")]
        public DatasetProperties DataAnalyticalApproaches { get; set; }

        [Display(Name = "32. Penetration Testing?")]
        public bool PreparationTesting { get; set; }

        #endregion

        #region Identify the disclosure control processes that are relevant to your data situation

        [Display(Name = "33. If you need to reconfigure the environment, how would you do that?")]
        public EnvironmentReconfigurationOptions ReconfigureEnvirontment { get; set; }

        [Display(Name = "34. If you need to modify the data, how would you do that?")]
        public DataModificationOptions ModifyingData { get; set; }

        [Display(Name = "35. Explanation:")]
        [StringLength(400)]
        public string ExplanationModifyingDataOptions { get; set; }


        #endregion

        #region Impact management puts in place a plan for reducing the impact of such ane vent should it happen

        [Display(Name = "36. How would you manage the impact of a disclosure (related to Notifiable Data Breach) if you and your stakeholders have developed a good working relationship. What have you done to reduce the likelihood to manage this?")]
        public DataBreachImpactManagementOptions ImpactManagementReductionOptions { get; set; }

        [Display(Name = "37. Who your stakeholders are and what assurances you provided them with in terms of the use and protection of the data")]
        public StakeholderAssuranceDataProtection StakeholdersAssurance { get; set; }

        [Display(Name = "38. Document the process you would follow in the event of a possible breach.")]
        public DataBreachPlanOptions PlanForDataBreachProcess { get; set; }

        [Display(Name = "39. Explanation:")]
        [StringLength(400)]
        public string DataBreachPlanExplanation { get; set; }

        #endregion

        #region Summary
        #endregion

        #region
        #endregion
    }
}
