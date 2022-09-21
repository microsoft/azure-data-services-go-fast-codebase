<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group_template_deployment.ingestion_private_endpoints](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blob_private_dns_id"></a> [blob\_private\_dns\_id](#input\_blob\_private\_dns\_id) | The id of the queue private DNS | `string` | n/a | yes |
| <a name="input_eventhub_privatelink_name"></a> [eventhub\_privatelink\_name](#input\_eventhub\_privatelink\_name) | The name of the eventhub private link | `string` | n/a | yes |
| <a name="input_managed_resource_group_name"></a> [managed\_resource\_group\_name](#input\_managed\_resource\_group\_name) | The name of the purview managed resource group | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Used to give resource group deployments unique names for an environment | `string` | n/a | yes |
| <a name="input_purview_account_name"></a> [purview\_account\_name](#input\_purview\_account\_name) | The name of the data factory | `string` | n/a | yes |
| <a name="input_queue_private_dns_id"></a> [queue\_private\_dns\_id](#input\_queue\_private\_dns\_id) | The id of the queue private DNS | `string` | n/a | yes |
| <a name="input_queue_privatelink_name"></a> [queue\_privatelink\_name](#input\_queue\_privatelink\_name) | The name of the queue private link | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy into | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | The uri of the shared keyvault | `string` | n/a | yes |
| <a name="input_servicebus_private_dns_id"></a> [servicebus\_private\_dns\_id](#input\_servicebus\_private\_dns\_id) | The id of the queue private DNS | `string` | n/a | yes |
| <a name="input_storage_privatelink_name"></a> [storage\_privatelink\_name](#input\_storage\_privatelink\_name) | The name of the storage private link | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The id of the subnet to attach the purview ingestion resources | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Id of the azure sub | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->