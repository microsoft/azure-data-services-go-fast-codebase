
data "azurerm_databricks_workspace" "databricks_workspace" {
  name                = "field-eng-east"
  resource_group_name = "field-eng-east"
}

data "azurerm_data_factory" "adf_gofast" {
  name                 = "AzureGoFast"
  resource_group_name = "oneenv"
}


resource "azurerm_data_factory_linked_service_azure_databricks" "msi_linked_allpurpose" {
  name                = "ADBLinkedServiceAllPurpose"
  data_factory_id     = data.azurerm_data_factory.adf_gofast.id
  description         = "ADB Linked Service via MSI"
  existing_cluster_id = "0812-165520-brine786" #needs to come from the WebUI

  msi_work_space_resource_id = data.azurerm_databricks_workspace.databricks_workspace.id
  adb_domain   = "https://${data.azurerm_databricks_workspace.databricks_workspace.workspace_url}"

 # adb_domain   = "https://adb-984752964297111.11.azuredatabricks.net"
}


resource "azurerm_data_factory_linked_service_azure_databricks" "msi_linked_newjob" {
  name                = "ADBLinkedServiceJob"
  data_factory_id     = data.azurerm_data_factory.adf_gofast.id
  description         = "ADB Linked Service via MSI"

  msi_work_space_resource_id = data.azurerm_databricks_workspace.databricks_workspace.id
  #adb_domain   = "https://adb-984752964297111.11.azuredatabricks.net"

  adb_domain   = "https://${data.azurerm_databricks_workspace.databricks_workspace.workspace_url}"



  new_cluster_config {
    node_type             = "Standard_NC12"
    cluster_version       = "5.5.x-gpu-scala2.11"
    min_number_of_workers = 1
    max_number_of_workers = 5
    driver_node_type      = "Standard_NC12"
    log_destination       = "dbfs:/logs"

    custom_tags = {
      custom_tag1 = "sct_value_1"
      custom_tag2 = "sct_value_2"
    }

    spark_config = {
      config1 = "value1"
      config2 = "value2"
    }

    spark_environment_variables = {
      envVar1 = "value1"
      envVar2 = "value2"
    }

    init_scripts = ["init.sh", "init2.sh"]
  }
}

