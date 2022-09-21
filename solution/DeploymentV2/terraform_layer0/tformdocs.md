## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | =2.22.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.12.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | =3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 0.5.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.12.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | Azure/naming/azurerm | 0.1.1 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.adls_state](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_bastion_host.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/bastion_host) | resource |
| [azurerm_network_interface.cicd_vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.app_service_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.bastion_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.plink_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.vm_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.app_service_in_deny_all](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_inbound_control_plane](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_inbound_data_plane](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_inbound_internet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_inbound_load_balancer](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_outbound_azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_outbound_bastion_vms](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_outbound_dataplane](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.bastion_outbound_internet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.plink_out_deny_all](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.vm_inbound_bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_zone.private_dns_zone_blob](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_db](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_dfs](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_kv](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_purview](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_purview_studio](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_queue](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_servicebus](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.synapse_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.synapse_sql](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.synapse_studio](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.blob](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.database](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.dfs](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.purview](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.purview_studio](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.queue](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.servicebus](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.synapse_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.synapse_sql](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.synapse_studio](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vaultcore](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.adls_dfs_state_storage_private_endpoint_with_dns](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.adls_state_storage_private_endpoint_with_dns](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.bastion_pip](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/public_ip) | resource |
| [azurerm_role_assignment.adls_state_deployment_agents](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.tstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/storage_container) | resource |
| [azurerm_subnet.app_service_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet) | resource |
| [azurerm_subnet.bastion_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet) | resource |
| [azurerm_subnet.plink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet) | resource |
| [azurerm_subnet.vm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.app_service_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.bastion_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.plink_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.vm_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_machine.cicd_vm_linux](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/resources/virtual_network) | resource |
| [random_id.rg_deployment_unique](https://registry.terraform.io/providers/hashicorp/random/3.3.0/docs/resources/id) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.12.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_functionapp_name"></a> [aad\_functionapp\_name](#input\_aad\_functionapp\_name) | The override name for the AAD App registration for the function app. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_aad_webapp_name"></a> [aad\_webapp\_name](#input\_aad\_webapp\_name) | The override name for the AAD App registration for the web app. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_adf_git_email_address"></a> [adf\_git\_email\_address](#input\_adf\_git\_email\_address) | The email address to be associated with the commit being done for the pipeline upload. | `string` | `""` | no |
| <a name="input_adf_git_host_url"></a> [adf\_git\_host\_url](#input\_adf\_git\_host\_url) | Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com. Use https://github.com for open source repositories. | `string` | `"https://github.com"` | no |
| <a name="input_adf_git_pat"></a> [adf\_git\_pat](#input\_adf\_git\_pat) | The personal access token used to authenticate the git account | `string` | `""` | no |
| <a name="input_adf_git_repository_branch_name"></a> [adf\_git\_repository\_branch\_name](#input\_adf\_git\_repository\_branch\_name) | The name of the github branch to be used | `string` | `"main"` | no |
| <a name="input_adf_git_repository_name"></a> [adf\_git\_repository\_name](#input\_adf\_git\_repository\_name) | The name of the github repository to be used for synapse | `string` | `""` | no |
| <a name="input_adf_git_repository_owner"></a> [adf\_git\_repository\_owner](#input\_adf\_git\_repository\_owner) | The owner of the github repository to be used for adf. Eg. for the repository https://github.com/contoso/ads, the owner is contoso | `string` | `""` | no |
| <a name="input_adf_git_repository_root_folder"></a> [adf\_git\_repository\_root\_folder](#input\_adf\_git\_repository\_root\_folder) | The name of the root folder to be used in the branch | `string` | `"/"` | no |
| <a name="input_adf_git_toggle_integration"></a> [adf\_git\_toggle\_integration](#input\_adf\_git\_toggle\_integration) | Feature toggle for enabling adf github integration | `bool` | `false` | no |
| <a name="input_adf_git_use_pat"></a> [adf\_git\_use\_pat](#input\_adf\_git\_use\_pat) | Whether a pat is required for authentication (non public repo). | `bool` | `true` | no |
| <a name="input_adf_git_user_name"></a> [adf\_git\_user\_name](#input\_adf\_git\_user\_name) | The user name to be associated with the commit being done for the pipeline upload. | `string` | `""` | no |
| <a name="input_adls_storage_account_name"></a> [adls\_storage\_account\_name](#input\_adls\_storage\_account\_name) | The override name for the storage account used for adls. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_allow_public_access_to_synapse_studio"></a> [allow\_public\_access\_to\_synapse\_studio](#input\_allow\_public\_access\_to\_synapse\_studio) | Should the synapse studio allow access to public IPs | `bool` | `false` | no |
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | The override name for the app insights resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The app\_name suffix value to be used for autogenerated naming conventions | `string` | `"ads"` | no |
| <a name="input_app_service_nsg_name"></a> [app\_service\_nsg\_name](#input\_app\_service\_nsg\_name) | The override name for the app service subnet NSG. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | The override name for the app service plan resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_app_service_sku"></a> [app\_service\_sku](#input\_app\_service\_sku) | The sku/scale of the app service | <pre>object({<br>    tier = string<br>    size = string<br>  capacity = number })</pre> | <pre>{<br>  "capacity": 1,<br>  "size": "S1",<br>  "tier": "Standard"<br>}</pre> | no |
| <a name="input_app_service_subnet_cidr"></a> [app\_service\_subnet\_cidr](#input\_app\_service\_subnet\_cidr) | CIDR of the subnet used to host the app service plan | `string` | `"10.0.0.128/26"` | no |
| <a name="input_app_service_subnet_name"></a> [app\_service\_subnet\_name](#input\_app\_service\_subnet\_name) | The override name for the app service subnet resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_author_tag"></a> [author\_tag](#input\_author\_tag) | The tags to apply to resources. | `string` | `"opensource.microsoft.com"` | no |
| <a name="input_azure_purview_data_curators"></a> [azure\_purview\_data\_curators](#input\_azure\_purview\_data\_curators) | List of Azure Purview Data Curators for default root | `map(string)` | `{}` | no |
| <a name="input_azure_sql_aad_administrators"></a> [azure\_sql\_aad\_administrators](#input\_azure\_sql\_aad\_administrators) | List of Azure SQL Administrators | `map(string)` | `{}` | no |
| <a name="input_bastion_ip_name"></a> [bastion\_ip\_name](#input\_bastion\_ip\_name) | The override name for the Bastion service Public IP. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_bastion_name"></a> [bastion\_name](#input\_bastion\_name) | The override name for the Bastion service. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_bastion_nsg_name"></a> [bastion\_nsg\_name](#input\_bastion\_nsg\_name) | The override name for the bastion subnet NSG. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_bastion_subnet_cidr"></a> [bastion\_subnet\_cidr](#input\_bastion\_subnet\_cidr) | CIDR of the subnet used for bastion | `string` | `"10.0.0.64/26"` | no |
| <a name="input_blob_storage_account_name"></a> [blob\_storage\_account\_name](#input\_blob\_storage\_account\_name) | The override name for the storage account used for staging data. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_cicd_sp_id"></a> [cicd\_sp\_id](#input\_cicd\_sp\_id) | The Object Id of the GitHub Service Principal. This will ensure that keyvault access policies are configured for GitHub/terraform to read secret state later | `string` | `""` | no |
| <a name="input_configure_networking"></a> [configure\_networking](#input\_configure\_networking) | Feature toggle for post IAC network configuration | `bool` | `true` | no |
| <a name="input_custom_vm_image_offer"></a> [custom\_vm\_image\_offer](#input\_custom\_vm\_image\_offer) | An Azure custom image marketplace image offer to be referenced for a custom vm image. | `string` | `""` | no |
| <a name="input_custom_vm_image_publisher"></a> [custom\_vm\_image\_publisher](#input\_custom\_vm\_image\_publisher) | An Azure custom image marketplace image publisher to be referenced for a custom vm image. | `string` | `""` | no |
| <a name="input_custom_vm_image_sku"></a> [custom\_vm\_image\_sku](#input\_custom\_vm\_image\_sku) | An Azure custom image marketplace image sku to be referenced for a custom vm image. | `string` | `""` | no |
| <a name="input_custom_vm_image_version"></a> [custom\_vm\_image\_version](#input\_custom\_vm\_image\_version) | An Azure custom image marketplace image version to be referenced for a custom vm image. | `string` | `"latest"` | no |
| <a name="input_custom_vm_os"></a> [custom\_vm\_os](#input\_custom\_vm\_os) | User must define whether they wish deploy a 'windows' or 'linux' virtual machine. | `string` | `"linux"` | no |
| <a name="input_custom_vm_plan_name"></a> [custom\_vm\_plan\_name](#input\_custom\_vm\_plan\_name) | An Azure vm plan name to be referenced for a custom vm image. | `string` | `""` | no |
| <a name="input_custom_vm_plan_product"></a> [custom\_vm\_plan\_product](#input\_custom\_vm\_plan\_product) | An Azure vm plan product to be referenced for a custom vm image. | `string` | `""` | no |
| <a name="input_custom_vm_plan_publisher"></a> [custom\_vm\_plan\_publisher](#input\_custom\_vm\_plan\_publisher) | An Azure vm plan publisher to be referenced for a custom vm image. | `string` | `""` | no |
| <a name="input_data_factory_name"></a> [data\_factory\_name](#input\_data\_factory\_name) | The override name for the Data Factory component. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_delay_private_access"></a> [delay\_private\_access](#input\_delay\_private\_access) | Whether to create resoruces with public access enabled and then disable it at the end. | `bool` | `true` | no |
| <a name="input_deploy_adls"></a> [deploy\_adls](#input\_deploy\_adls) | Feature toggle for deploying the internal data lake | `bool` | `true` | no |
| <a name="input_deploy_app_insights"></a> [deploy\_app\_insights](#input\_deploy\_app\_insights) | Feature toggle for deploying the App Insights | `bool` | `true` | no |
| <a name="input_deploy_app_service_plan"></a> [deploy\_app\_service\_plan](#input\_deploy\_app\_service\_plan) | Feature toggle for deploying the App Service | `bool` | `true` | no |
| <a name="input_deploy_azure_ad_function_app_registration"></a> [deploy\_azure\_ad\_function\_app\_registration](#input\_deploy\_azure\_ad\_function\_app\_registration) | Feature toggle for deploying the Azure AD App registration for the Function App | `bool` | `true` | no |
| <a name="input_deploy_azure_ad_web_app_registration"></a> [deploy\_azure\_ad\_web\_app\_registration](#input\_deploy\_azure\_ad\_web\_app\_registration) | Feature toggle for deploying the Azure AD App registration for the Web Portal | `bool` | `true` | no |
| <a name="input_deploy_azure_role_assignments"></a> [deploy\_azure\_role\_assignments](#input\_deploy\_azure\_role\_assignments) | Feature toggle for deploying the Azure Role Assignments | `bool` | `true` | no |
| <a name="input_deploy_bastion"></a> [deploy\_bastion](#input\_deploy\_bastion) | Feature toggle for deploying bastion | `bool` | `true` | no |
| <a name="input_deploy_cicd_vm"></a> [deploy\_cicd\_vm](#input\_deploy\_cicd\_vm) | Set to true if you want to deploy a vm to host the github runnner. | `bool` | `false` | no |
| <a name="input_deploy_custom_terraform"></a> [deploy\_custom\_terraform](#input\_deploy\_custom\_terraform) | Whether the platform deploys the infrastructure located in the terraform\_custom folder | `bool` | `false` | no |
| <a name="input_deploy_custom_vm"></a> [deploy\_custom\_vm](#input\_deploy\_custom\_vm) | Feature toggle for deploying a custom virtual machine | `bool` | `false` | no |
| <a name="input_deploy_data_factory"></a> [deploy\_data\_factory](#input\_deploy\_data\_factory) | Feature toggle for deploying the Azure Data Factory | `bool` | `true` | no |
| <a name="input_deploy_function_app"></a> [deploy\_function\_app](#input\_deploy\_function\_app) | Feature toggle for deploying the Function App | `bool` | `true` | no |
| <a name="input_deploy_h2o-ai"></a> [deploy\_h2o-ai](#input\_deploy\_h2o-ai) | Feature toggle for deploying H2O-AI VM | `bool` | `false` | no |
| <a name="input_deploy_metadata_database"></a> [deploy\_metadata\_database](#input\_deploy\_metadata\_database) | Feature toggle for deploying Metadata Database | `bool` | `true` | no |
| <a name="input_deploy_purview"></a> [deploy\_purview](#input\_deploy\_purview) | Feature toggle for deploying Azure Purview | `bool` | `false` | no |
| <a name="input_deploy_selfhostedsql"></a> [deploy\_selfhostedsql](#input\_deploy\_selfhostedsql) | Feature toggle for deploying Self Hosted Sql VM | `bool` | `false` | no |
| <a name="input_deploy_sentinel"></a> [deploy\_sentinel](#input\_deploy\_sentinel) | Feature toggle for deploying Azure Sentinel | `bool` | `false` | no |
| <a name="input_deploy_sql_extend_audit_policy"></a> [deploy\_sql\_extend\_audit\_policy](#input\_deploy\_sql\_extend\_audit\_policy) | Feature toggle for deploying the SQL Server Extended Audit policy | `bool` | `true` | no |
| <a name="input_deploy_sql_server"></a> [deploy\_sql\_server](#input\_deploy\_sql\_server) | Feature toggle for deploying the SQL Server | `bool` | `true` | no |
| <a name="input_deploy_state_storage_account"></a> [deploy\_state\_storage\_account](#input\_deploy\_state\_storage\_account) | Set to true if you want to deploy a the state storage account. | `bool` | `false` | no |
| <a name="input_deploy_storage_account"></a> [deploy\_storage\_account](#input\_deploy\_storage\_account) | Feature toggle for deploying the internal storage account | `bool` | `true` | no |
| <a name="input_deploy_synapse"></a> [deploy\_synapse](#input\_deploy\_synapse) | Feature toggle for deploying Azure Synapse | `bool` | `false` | no |
| <a name="input_deploy_synapse_sparkpool"></a> [deploy\_synapse\_sparkpool](#input\_deploy\_synapse\_sparkpool) | Feature toggle for deploying Azure Synapse Spark Pool | `bool` | `true` | no |
| <a name="input_deploy_synapse_sqlpool"></a> [deploy\_synapse\_sqlpool](#input\_deploy\_synapse\_sqlpool) | Feature toggle for deploying Azure Synapse SQL Pool | `bool` | `true` | no |
| <a name="input_deploy_web_app"></a> [deploy\_web\_app](#input\_deploy\_web\_app) | Feature toggle for deploying the Web App | `bool` | `true` | no |
| <a name="input_deployment_principal_layers1and3"></a> [deployment\_principal\_layers1and3](#input\_deployment\_principal\_layers1and3) | Object Id of the azure account that will deploy layers 1 & 3. If it is the same as the layer 2 user then leave as empty string. | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The AAD domain | `string` | n/a | yes |
| <a name="input_environment_tag"></a> [environment\_tag](#input\_environment\_tag) | The name of the environment. Don't use spaces | `string` | `"dev"` | no |
| <a name="input_existing_app_service_subnet_id"></a> [existing\_app\_service\_subnet\_id](#input\_existing\_app\_service\_subnet\_id) | An existing subnet id for reuse for the App Service delegation | `string` | `""` | no |
| <a name="input_existing_bastion_subnet_id"></a> [existing\_bastion\_subnet\_id](#input\_existing\_bastion\_subnet\_id) | An existing subnet id for reuse for the Bastion host | `string` | `""` | no |
| <a name="input_existing_log_analytics_resource_id"></a> [existing\_log\_analytics\_resource\_id](#input\_existing\_log\_analytics\_resource\_id) | An existing log analytics resource id for reuse | `string` | `""` | no |
| <a name="input_existing_log_analytics_workspace_id"></a> [existing\_log\_analytics\_workspace\_id](#input\_existing\_log\_analytics\_workspace\_id) | An existing log analytics workspace id for reuse | `string` | `""` | no |
| <a name="input_existing_plink_subnet_id"></a> [existing\_plink\_subnet\_id](#input\_existing\_plink\_subnet\_id) | An existing subnet id for reuse for the Private link resources | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_blob_id"></a> [existing\_private\_dns\_zone\_blob\_id](#input\_existing\_private\_dns\_zone\_blob\_id) | An existing private DNS zone for privatelink.blob.core.azure.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_db_id"></a> [existing\_private\_dns\_zone\_db\_id](#input\_existing\_private\_dns\_zone\_db\_id) | An existing private DNS zone for privatelink.database.windows.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_dfs_id"></a> [existing\_private\_dns\_zone\_dfs\_id](#input\_existing\_private\_dns\_zone\_dfs\_id) | An existing private DNS zone for privatelink.dfs.core.azure.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_kv_id"></a> [existing\_private\_dns\_zone\_kv\_id](#input\_existing\_private\_dns\_zone\_kv\_id) | An existing private DNS zone for privatelink.vaultcore.azure.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_purview_id"></a> [existing\_private\_dns\_zone\_purview\_id](#input\_existing\_private\_dns\_zone\_purview\_id) | An existing private DNS zone for privatelink.purview.azure.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_purview_studio_id"></a> [existing\_private\_dns\_zone\_purview\_studio\_id](#input\_existing\_private\_dns\_zone\_purview\_studio\_id) | An existing private DNS zone for privatelink.purviewstudio.azure.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_queue_id"></a> [existing\_private\_dns\_zone\_queue\_id](#input\_existing\_private\_dns\_zone\_queue\_id) | An existing private DNS zone for privatelink.queue.core.azure.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_servicebus_id"></a> [existing\_private\_dns\_zone\_servicebus\_id](#input\_existing\_private\_dns\_zone\_servicebus\_id) | An existing private DNS zone for privatelink.servicebus.windows.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_synapse_gateway_id"></a> [existing\_private\_dns\_zone\_synapse\_gateway\_id](#input\_existing\_private\_dns\_zone\_synapse\_gateway\_id) | An existing private DNS zone for privatelink.azuresynapse.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_synapse_sql_id"></a> [existing\_private\_dns\_zone\_synapse\_sql\_id](#input\_existing\_private\_dns\_zone\_synapse\_sql\_id) | An existing private DNS zone for privatelink.sql.azuresynapse.net | `string` | `""` | no |
| <a name="input_existing_private_dns_zone_synapse_studio_id"></a> [existing\_private\_dns\_zone\_synapse\_studio\_id](#input\_existing\_private\_dns\_zone\_synapse\_studio\_id) | An existing private DNS zone for privatelink.dev.azuresynapse.net | `string` | `""` | no |
| <a name="input_existing_synapse_private_link_hub_id"></a> [existing\_synapse\_private\_link\_hub\_id](#input\_existing\_synapse\_private\_link\_hub\_id) | An existing private link hub for synapse studio. | `string` | `""` | no |
| <a name="input_existing_vm_subnet_id"></a> [existing\_vm\_subnet\_id](#input\_existing\_vm\_subnet\_id) | An existing subnet id for reuse for the Agent VMs | `string` | `""` | no |
| <a name="input_existing_vnet_id"></a> [existing\_vnet\_id](#input\_existing\_vnet\_id) | An existing virtual network. | `string` | `""` | no |
| <a name="input_functionapp_name"></a> [functionapp\_name](#input\_functionapp\_name) | The override name for the function app service resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | The CICD ipaddress. We add an IP whitelisting to allow the setting of keyvault secrets | `string` | `""` | no |
| <a name="input_ip_address2"></a> [ip\_address2](#input\_ip\_address2) | The CICD ipaddress. We add an IP whitelisting to allow the setting of keyvault secrets | `string` | `""` | no |
| <a name="input_is_onprem_datafactory_ir_registered"></a> [is\_onprem\_datafactory\_ir\_registered](#input\_is\_onprem\_datafactory\_ir\_registered) | Are all on-premise Integration runtimes configured? | `bool` | `false` | no |
| <a name="input_is_private_network"></a> [is\_private\_network](#input\_is\_private\_network) | If true will disable public IP's entirely | `bool` | `false` | no |
| <a name="input_is_vnet_isolated"></a> [is\_vnet\_isolated](#input\_is\_vnet\_isolated) | Whether to deploy the resources as vnet attached / private linked | `bool` | `true` | no |
| <a name="input_jumphost_password"></a> [jumphost\_password](#input\_jumphost\_password) | Password for the jumphost | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The override name for the keyvault resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The override name for the Log Analytics workspace. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_logs_storage_account_name"></a> [logs\_storage\_account\_name](#input\_logs\_storage\_account\_name) | The override name for the storage account used for logs. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_owner_tag"></a> [owner\_tag](#input\_owner\_tag) | The tags to apply to resources. | `string` | `"opensource.microsoft.com"` | no |
| <a name="input_plink_nsg_name"></a> [plink\_nsg\_name](#input\_plink\_nsg\_name) | The override name for the private link subnet NSG. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_plink_subnet_cidr"></a> [plink\_subnet\_cidr](#input\_plink\_subnet\_cidr) | CIDR of the subnet used for private link endpoints | `string` | `"10.0.0.0/26"` | no |
| <a name="input_plink_subnet_name"></a> [plink\_subnet\_name](#input\_plink\_subnet\_name) | The override name for the private link subnet resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix value to be used for autogenerated naming conventions | `string` | `"ark"` | no |
| <a name="input_publish_datafactory_pipelines"></a> [publish\_datafactory\_pipelines](#input\_publish\_datafactory\_pipelines) | Feature toggle for post IAC data factory pipeline deployment | `bool` | `true` | no |
| <a name="input_publish_function_app"></a> [publish\_function\_app](#input\_publish\_function\_app) | Feature toggle for Publishing Function Application Code Base | `bool` | `true` | no |
| <a name="input_publish_functional_tests"></a> [publish\_functional\_tests](#input\_publish\_functional\_tests) | Feature toggle for Publishing Functional Tests to the Web App | `bool` | `false` | no |
| <a name="input_publish_metadata_database"></a> [publish\_metadata\_database](#input\_publish\_metadata\_database) | Feature toggle for Publishing Metadata Database schema and seeding with data | `bool` | `true` | no |
| <a name="input_publish_purview_configuration"></a> [publish\_purview\_configuration](#input\_publish\_purview\_configuration) | Feature toggle for deploying the Purview configuration script (WIP) | `bool` | `false` | no |
| <a name="input_publish_sample_files"></a> [publish\_sample\_files](#input\_publish\_sample\_files) | Feature toggle for Publishing Sample Filess | `bool` | `true` | no |
| <a name="input_publish_sif_database"></a> [publish\_sif\_database](#input\_publish\_sif\_database) | Feature toggle for Publishing SIF Database | `bool` | `false` | no |
| <a name="input_publish_sql_logins"></a> [publish\_sql\_logins](#input\_publish\_sql\_logins) | Feature toggle for Publishing Synapse / SQL database logins for lockbox | `bool` | `true` | no |
| <a name="input_publish_web_app"></a> [publish\_web\_app](#input\_publish\_web\_app) | Feature toggle for Publishing Web Application Code Base | `bool` | `true` | no |
| <a name="input_publish_web_app_addcurrentuserasadmin"></a> [publish\_web\_app\_addcurrentuserasadmin](#input\_publish\_web\_app\_addcurrentuserasadmin) | Feature toggle for adding user running deployment as a webapp admin | `bool` | `false` | no |
| <a name="input_purview_ir_app_reg_name"></a> [purview\_ir\_app\_reg\_name](#input\_purview\_ir\_app\_reg\_name) | The override name for the Purview Integration runtime SP. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_purview_name"></a> [purview\_name](#input\_purview\_name) | The override name for the Purview component. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_purview_resource_location"></a> [purview\_resource\_location](#input\_purview\_resource\_location) | The override location for the Purview component. If empty, will be autogenerated based global location settings | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | The Azure Region being deployed to. | `string` | `"Australia East"` | no |
| <a name="input_resource_owners"></a> [resource\_owners](#input\_resource\_owners) | A web app Azure security group used for admin access. | `list(string)` | `[]` | no |
| <a name="input_sif_database_name"></a> [sif\_database\_name](#input\_sif\_database\_name) | SIF DataMart Name | `string` | `"sif"` | no |
| <a name="input_sql_admin_username"></a> [sql\_admin\_username](#input\_sql\_admin\_username) | The username for the sql server admin | `string` | `"adsgofastsqladminuser11"` | no |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | The override name for the sql server resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_state_storage_account_name"></a> [state\_storage\_account\_name](#input\_state\_storage\_account\_name) | The override name for the storage account used for storing state data. If empty, will be autogenerated. | `string` | `""` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure Subscription ID | `string` | n/a | yes |
| <a name="input_synapse_administrators"></a> [synapse\_administrators](#input\_synapse\_administrators) | List of Synapse Administrators | `map(string)` | `{}` | no |
| <a name="input_synapse_contributors"></a> [synapse\_contributors](#input\_synapse\_contributors) | List of Synapse Contributors | `map(string)` | `{}` | no |
| <a name="input_synapse_data_lake_name"></a> [synapse\_data\_lake\_name](#input\_synapse\_data\_lake\_name) | The override name for the Synapse data lake component. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_synapse_dwpool_name"></a> [synapse\_dwpool\_name](#input\_synapse\_dwpool\_name) | The override name for the Synapse Dedicated Pool component. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_synapse_git_devops_project_name"></a> [synapse\_git\_devops\_project\_name](#input\_synapse\_git\_devops\_project\_name) | The name of the project to be referenced within devops. Note: Not used for github. | `string` | `"/"` | no |
| <a name="input_synapse_git_devops_tenant_id"></a> [synapse\_git\_devops\_tenant\_id](#input\_synapse\_git\_devops\_tenant\_id) | The tenant id of the devops project. By default it will be valued as your tenant\_id. Note: Not used for github. | `string` | `""` | no |
| <a name="input_synapse_git_email_address"></a> [synapse\_git\_email\_address](#input\_synapse\_git\_email\_address) | The email address to be associated with the commit being done for the pipeline upload. | `string` | `""` | no |
| <a name="input_synapse_git_github_host_url"></a> [synapse\_git\_github\_host\_url](#input\_synapse\_git\_github\_host\_url) | Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com. Use https://github.com for open source repositories. Note: Not used for devops | `string` | `"https://github.com"` | no |
| <a name="input_synapse_git_integration_type"></a> [synapse\_git\_integration\_type](#input\_synapse\_git\_integration\_type) | User must define whether they wish to use 'github' integration or 'devops' | `string` | `"github"` | no |
| <a name="input_synapse_git_pat"></a> [synapse\_git\_pat](#input\_synapse\_git\_pat) | The personal access token used to authenticate the git account | `string` | `""` | no |
| <a name="input_synapse_git_repository_branch_name"></a> [synapse\_git\_repository\_branch\_name](#input\_synapse\_git\_repository\_branch\_name) | The name of the github branch to be used | `string` | `"main"` | no |
| <a name="input_synapse_git_repository_name"></a> [synapse\_git\_repository\_name](#input\_synapse\_git\_repository\_name) | The name of the github repository to be used for synapse | `string` | `""` | no |
| <a name="input_synapse_git_repository_owner"></a> [synapse\_git\_repository\_owner](#input\_synapse\_git\_repository\_owner) | The owner of the github repository to be used for synapse. Eg. for the repository https://github.com/contoso/ads, the owner is contoso | `string` | `""` | no |
| <a name="input_synapse_git_repository_root_folder"></a> [synapse\_git\_repository\_root\_folder](#input\_synapse\_git\_repository\_root\_folder) | The name of the root folder to be used in the branch | `string` | `"/"` | no |
| <a name="input_synapse_git_toggle_integration"></a> [synapse\_git\_toggle\_integration](#input\_synapse\_git\_toggle\_integration) | Feature toggle for enabling synapse github integration | `bool` | `false` | no |
| <a name="input_synapse_git_use_pat"></a> [synapse\_git\_use\_pat](#input\_synapse\_git\_use\_pat) | Whether a pat is required for authentication (non public repo). | `bool` | `true` | no |
| <a name="input_synapse_git_user_name"></a> [synapse\_git\_user\_name](#input\_synapse\_git\_user\_name) | The user name to be associated with the commit being done for the pipeline upload. | `string` | `""` | no |
| <a name="input_synapse_publishers"></a> [synapse\_publishers](#input\_synapse\_publishers) | List of Synapse Publishers | `map(string)` | `{}` | no |
| <a name="input_synapse_sku"></a> [synapse\_sku](#input\_synapse\_sku) | The sku/scale of the Synapse SQL Pool | `string` | `"DW100c"` | no |
| <a name="input_synapse_spark_max_node_count"></a> [synapse\_spark\_max\_node\_count](#input\_synapse\_spark\_max\_node\_count) | The maximum number of spark nodes in the autoscale pool | `number` | `12` | no |
| <a name="input_synapse_spark_min_node_count"></a> [synapse\_spark\_min\_node\_count](#input\_synapse\_spark\_min\_node\_count) | The minimum number of spark nodes in the autoscale pool | `number` | `3` | no |
| <a name="input_synapse_sppool_name"></a> [synapse\_sppool\_name](#input\_synapse\_sppool\_name) | The override name for the Synapse spark pool component. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_synapse_sql_login"></a> [synapse\_sql\_login](#input\_synapse\_sql\_login) | Login for the Azure Synapse SQL admin | `string` | `"adsgofastsynapseadminuser14"` | no |
| <a name="input_synapse_workspace_name"></a> [synapse\_workspace\_name](#input\_synapse\_workspace\_name) | The override name for the Synapse workspace component. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The AAD tenant ID | `string` | n/a | yes |
| <a name="input_vm_nsg_name"></a> [vm\_nsg\_name](#input\_vm\_nsg\_name) | The override name for the VM subnet NSG. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_vm_subnet_cidr"></a> [vm\_subnet\_cidr](#input\_vm\_subnet\_cidr) | CIDR of the subnet used to host VM compute resources | `string` | `"10.0.0.192/26"` | no |
| <a name="input_vm_subnet_name"></a> [vm\_subnet\_name](#input\_vm\_subnet\_name) | The override name for the vm subnet resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | CIDR of the vnet | `string` | `"10.0.0.0/24"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The override name for the Virtual Network resource. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |
| <a name="input_web_app_admin_security_group"></a> [web\_app\_admin\_security\_group](#input\_web\_app\_admin\_security\_group) | A web app Azure security group used for admin access. | `string` | `""` | no |
| <a name="input_webapp_name"></a> [webapp\_name](#input\_webapp\_name) | The override name for the web app service. If empty, will be autogenerated based on prefix settings | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_subnet_id"></a> [app\_service\_subnet\_id](#output\_app\_service\_subnet\_id) | n/a |
| <a name="output_azurerm_virtual_network_vnet_name"></a> [azurerm\_virtual\_network\_vnet\_name](#output\_azurerm\_virtual\_network\_vnet\_name) | n/a |
| <a name="output_naming_unique_seed"></a> [naming\_unique\_seed](#output\_naming\_unique\_seed) | n/a |
| <a name="output_naming_unique_suffix"></a> [naming\_unique\_suffix](#output\_naming\_unique\_suffix) | n/a |
| <a name="output_plink_subnet_id"></a> [plink\_subnet\_id](#output\_plink\_subnet\_id) | n/a |
| <a name="output_private_dns_zone_blob_id"></a> [private\_dns\_zone\_blob\_id](#output\_private\_dns\_zone\_blob\_id) | n/a |
| <a name="output_private_dns_zone_db_id"></a> [private\_dns\_zone\_db\_id](#output\_private\_dns\_zone\_db\_id) | n/a |
| <a name="output_private_dns_zone_dfs_id"></a> [private\_dns\_zone\_dfs\_id](#output\_private\_dns\_zone\_dfs\_id) | n/a |
| <a name="output_private_dns_zone_kv_id"></a> [private\_dns\_zone\_kv\_id](#output\_private\_dns\_zone\_kv\_id) | n/a |
| <a name="output_private_dns_zone_purview_id"></a> [private\_dns\_zone\_purview\_id](#output\_private\_dns\_zone\_purview\_id) | n/a |
| <a name="output_private_dns_zone_purview_studio_id"></a> [private\_dns\_zone\_purview\_studio\_id](#output\_private\_dns\_zone\_purview\_studio\_id) | n/a |
| <a name="output_private_dns_zone_queue_id"></a> [private\_dns\_zone\_queue\_id](#output\_private\_dns\_zone\_queue\_id) | n/a |
| <a name="output_private_dns_zone_servicebus_id"></a> [private\_dns\_zone\_servicebus\_id](#output\_private\_dns\_zone\_servicebus\_id) | n/a |
| <a name="output_private_dns_zone_synapse_gateway_id"></a> [private\_dns\_zone\_synapse\_gateway\_id](#output\_private\_dns\_zone\_synapse\_gateway\_id) | n/a |
| <a name="output_private_dns_zone_synapse_sql_id"></a> [private\_dns\_zone\_synapse\_sql\_id](#output\_private\_dns\_zone\_synapse\_sql\_id) | n/a |
| <a name="output_private_dns_zone_synapse_studio_id"></a> [private\_dns\_zone\_synapse\_studio\_id](#output\_private\_dns\_zone\_synapse\_studio\_id) | n/a |
| <a name="output_vm_subnet_id"></a> [vm\_subnet\_id](#output\_vm\_subnet\_id) | n/a |
