function (featuretemplatename="full_deployment",environment="staging", gitDeploy="False")
local locals = {
/*DONOTREMOVETHISCOMMENT:ENVS*/
     'admz' : import './admz/common_vars_values.jsonc',
     'local' : import './local/common_vars_values.jsonc',
     'production' : import './production/common_vars_values.jsonc',
     'staging' : import './staging/common_vars_values.jsonc',
     'uat' : import './uat/common_vars_values.jsonc',
/*DONOTREMOVETHISCOMMENT:ENVS*/
};
local featuretemplates = {
/*DONOTREMOVETHISCOMMENT:SOFTS*/
     'basic_deployment' : import './../featuretemplates/basic_deployment.jsonc',
     'full_deployment_no_purview' : import './../featuretemplates/full_deployment_no_purview.jsonc',
     'full_deployment_with_ixup' : import './../featuretemplates/full_deployment_with_ixup.jsonc',
     'full_deployment' : import './../featuretemplates/full_deployment.jsonc',
     'functional_tests' : import './../featuretemplates/functional_tests.jsonc',
/*DONOTREMOVETHISCOMMENT:SOFTS*/
};
local featuretemplate =     [  // Object comprehension.
    {
        ["CICDSecretName"]: "",
        ["EnvVarName"]: "TF_VAR_" + sd.Name,
        ["HCLName"]: "",
        ["Value"]: sd.Value,
        ["DoNotReplaceDuringAgentDeployment"]: false
    }
    for sd in featuretemplates[featuretemplatename]
    ];
local AllVariables = [            
        /*Attributes: 
            CICDSecretName: Name of the Secret that will hold the value in CICD. This mapps to the Env section of the CICD yaml",
            EnvVarName:     Name to be used when creating local environment Variable if this is blank no local environment variable will be created
            HCLName:        Name to be used when common_vars.yaml which is injected into HCL file. If this is blank it will not be included in HCL
        */  
        /*
            Environment Only Vars 
            - these are not used in local console based deployments. Only when runnning in git hub
        */
         {
            "CICDSecretName": "WEB_APP_ADMIN_USER",
            "EnvVarName": "WEB_APP_ADMIN_USER",
            "HCLName": "",
            "Value": locals[environment].WEB_APP_ADMIN_USER,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_SYNAPSE_WORKSPACE_NAME",
            "EnvVarName": "ARM_SYNAPSE_WORKSPACE_NAME",
            "HCLName": "",
            "Value": locals[environment].ARM_SYNAPSE_WORKSPACE_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_KEYVAULT_NAME",
            "EnvVarName": "keyVaultName",
            "HCLName": "",
            "Value": locals[environment].ARM_KEYVAULT_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_DATALAKE_NAME",
            "EnvVarName": "datalakeName",
            "HCLName": "",
            "Value": locals[environment].ARM_DATALAKE_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        /*
            Required for Automated CICD Deployment 
        */
        {
            "CICDSecretName": "ARM_CLIENT_ID",
            "EnvVarName": "ARM_CLIENT_ID",
            "HCLName": "",
            "Value": "#####",
            "Sensitive": true,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_PAL_PARTNER_ID",
            "EnvVarName": "ARM_PAL_PARTNER_ID",
            "HCLName": "",
            "Value": locals[environment].ARM_PAL_PARTNER_ID,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_CLIENT_SECRET",
            "EnvVarName": "ARM_CLIENT_SECRET",
            "HCLName": "",
            "Value": "#####",
            "Sensitive": true,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_SUBSCRIPTION_ID",
            "EnvVarName": "ARM_SUBSCRIPTION_ID",
            "HCLName": "",
            "Value":  locals[environment].subscription_id,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_TENANT_ID",
            "EnvVarName": "ARM_TENANT_ID",
            "HCLName": "tenant_id",
            "Value": locals[environment].tenant_id,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "TF_VAR_tenant_id",
            "HCLName": "",
            "Value": locals[environment].tenant_id,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },        /*
            HCL Common Vars & Terraform Customisations 
        */
        {                    
            "CICDSecretName": "",
            "EnvVarName": "",
            "HCLName": "owner_tag",
            "Value": locals[environment].owner_tag,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "",
            "HCLName": "deployment_principal_layers1and3",
            "Value": locals[environment].deployment_principal_layers1and3,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "",
            "HCLName": "resource_location",
            "Value": locals[environment].resource_location,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ENVIRONMENT_TAG",
            "EnvVarName": "TF_VAR_environment_tag",
            "HCLName": "environment_tag",
            "Value": locals[environment].environment_tag,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_DOMAIN",
            "EnvVarName": "TF_VAR_domain",
            "HCLName": "domain",
            "Value": locals[environment].domain,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "TF_VAR_subscription_id",
            "HCLName": "subscription_id",
            "Value": locals[environment].subscription_id,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "",
            "HCLName": "prefix",
            "Value": locals[environment].prefix,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_RESOURCE_GROUP_NAME",            
            "EnvVarName": "TF_VAR_resource_group_name",
            "HCLName": "resource_group_name",
            "Value": locals[environment].resource_group_name,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "ARM_IP_ADDRESS",
            "EnvVarName": "TF_VAR_ip_address",
            "HCLName": "ip_address",
            "Value": locals[environment].ip_address,
            "Sensitive": false,            
            "DoNotReplaceDuringAgentDeployment":true
        },
        {
            "CICDSecretName": "ARM_IP_ADDRESS2",
            "EnvVarName": "TF_VAR_ip_address2",
            "HCLName": "ip_address2",
            "Value": locals[environment].ip_address2,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "",            
            "EnvVarName": "",            
            "HCLName": "synapse_administrators",
            "Value": locals[environment].synapse_administrators,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "",            
            "EnvVarName": "",            
            "HCLName": "synapse_publishers",
            "Value": locals[environment].synapse_publishers,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "",            
            "EnvVarName": "",            
            "HCLName": "synapse_contributors",
            "Value": locals[environment].synapse_contributors,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "",            
            "EnvVarName": "TF_VAR_azure_sql_aad_administrators",            
            "HCLName": "azure_sql_aad_administrators",
            "Value": locals[environment].azure_sql_aad_administrators,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "",            
            "EnvVarName": "TF_VAR_azure_purview_data_curators",            
            "HCLName": "azure_purview_data_curators",
            "Value": locals[environment].azure_purview_data_curators,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },          
        {            
            "CICDSecretName": "",            
            "EnvVarName": "",            
            "HCLName": "resource_owners",
            "Value": locals[environment].resource_owners,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "ARM_FEATURE_TEMPLATE",            
            "EnvVarName": "ARM_FEATURE_TEMPLATE",            
            "HCLName": "",
            "Value": featuretemplatename,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "ARM_STORAGE_NAME",            
            "EnvVarName": "TF_VAR_state_storage_account_name",            
            "HCLName": "state_storage_account_name",
            "Value": locals[environment].state_storage_account_name,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "ARM_SYNAPSE_PASSWORD",            
            "EnvVarName": "TF_VAR_synapse_sql_password",            
            "HCLName": "",
            "Value": "#####",
            "Sensitive": true,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {            
            "CICDSecretName": "ARM_JUMPHOST_PASSWORD",            
            "EnvVarName": "TF_VAR_jumphost_password",            
            "HCLName": "",
            "Value": "#####",
            "Sensitive": true,
            "DoNotReplaceDuringAgentDeployment":false
        },        
        {            
            "CICDSecretName": "WEB_APP_ADMIN_SECURITY_GROUP",            
            "EnvVarName": "TF_VAR_web_app_admin_security_group",            
            "HCLName": "",
            "Value": locals[environment].WEB_APP_ADMIN_SECURITY_GROUP,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        /*
            Git Integration Set-Up
        */
        {
            "CICDSecretName": "GIT_REPOSITORY_NAME",
            "EnvVarName": "TF_VAR_synapse_git_repository_name",
            "HCLName": "",
            "Value":  locals[environment].GIT_REPOSITORY_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_SYNAPSE_REPOSITORY_BRANCH_NAME",
            "EnvVarName": "TF_VAR_synapse_git_repository_branch_name",
            "HCLName": "",
            "Value":  locals[environment].GIT_SYNAPSE_REPOSITORY_BRANCH_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_PAT",
            "EnvVarName": "TF_VAR_synapse_git_pat",
            "HCLName": "",
            "Value":  "#####",
            "Sensitive": true,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_USER_NAME",
            "EnvVarName": "TF_VAR_synapse_git_user_name",
            "HCLName": "",
            "Value":  locals[environment].GIT_USER_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_EMAIL_ADDRESS",
            "EnvVarName": "TF_VAR_synapse_git_email_address",
            "HCLName": "",
            "Value":  locals[environment].GIT_EMAIL_ADDRESS,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_ADF_REPOSITORY_NAME",
            "EnvVarName": "TF_VAR_adf_git_repository_name",
            "HCLName": "",
            "Value":  locals[environment].GIT_ADF_REPOSITORY_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_ADF_REPOSITORY_BRANCH_NAME",
            "EnvVarName": "TF_VAR_adf_git_repository_branch_name",
            "HCLName": "",
            "Value":  locals[environment].GIT_ADF_REPOSITORY_BRANCH_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_ADF_PAT",
            "EnvVarName": "TF_VAR_adf_git_pat",
            "HCLName": "",
            "Value":  "#####",
            "Sensitive": true,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_ADF_USER_NAME",
            "EnvVarName": "TF_VAR_adf_git_user_name",
            "HCLName": "",
            "Value":  locals[environment].GIT_ADF_USER_NAME,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "GIT_ADF_EMAIL_ADDRESS",
            "EnvVarName": "TF_VAR_adf_git_email_address",
            "HCLName": "",
            "Value":  locals[environment].GIT_ADF_EMAIL_ADDRESS,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "TF_VAR_is_private_network",
            "HCLName": "is_private_network",
            "Value":  locals[environment].is_private_network,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "TF_VAR_deploy_state_storage_account",
            "HCLName": "deploy_state_storage_account",
            "Value":  locals[environment].deploy_state_storage_account,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        },
        {
            "CICDSecretName": "",
            "EnvVarName": "TF_VAR_deploy_cicd_vm",
            "HCLName": "deploy_cicd_vm",
            "Value":  locals[environment].deploy_cicd_vm,
            "Sensitive": false,
            "DoNotReplaceDuringAgentDeployment":false
        }
    ]+featuretemplate;
local HCLVariables =     {  // Object comprehension.
    [sd.HCLName]: sd.Value        
    for sd in AllVariables
    if sd.HCLName != ""
};
local EnvironmentVariables =     {  // Object comprehension.
    [sd.EnvVarName]: sd.Value        
    for sd in AllVariables
    if sd.EnvVarName != "" && ((std.asciiLower(gitDeploy) == "false") || (std.asciiLower(gitDeploy) == "true" && sd.DoNotReplaceDuringAgentDeployment == false))
};
local SecretFileVars =     {  // Object comprehension.
    [sd.CICDSecretName]: sd.Value        
    for sd in AllVariables
    if sd.CICDSecretName != "" && sd.Sensitive == false
};
local SecretFileSensitiveVars =     {  // Object comprehension.
    [sd.CICDSecretName]: sd.Value        
    for sd in AllVariables
    if sd.CICDSecretName != "" && sd.Sensitive == true
};
{        
    "ForHCL": HCLVariables,
    "ForEnvVar": EnvironmentVariables,
    "ForSecretFile": SecretFileVars,
    "ForSecretFileSensitive": SecretFileSensitiveVars
}
