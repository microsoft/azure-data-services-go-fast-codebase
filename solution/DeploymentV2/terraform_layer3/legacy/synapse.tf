
/* resource "null_resource" "synapsedb_admins" {
  for_each = (var.azure_sql_aad_administrators)  
  provisioner "local-exec" {
    working_dir = path.module
    command = "pwsh -file database.ps1 -user ${each.key} -sqlserver_name ${local.sql_server_name} -database ${local.sample_database_name}"    
  }
  
}  */
