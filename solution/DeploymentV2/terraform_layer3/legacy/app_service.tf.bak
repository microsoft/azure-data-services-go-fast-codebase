
resource "null_resource" "webapp_admins" {
  #for_each = (var.azure_sql_aad_administrators)  
  provisioner "local-exec" {
    working_dir = path.module
    command = "pwsh -file app_service.ps1 -aad_webreg_id ${data.terraform_remote_state.layer2.outputs.aad_webreg_id}"    
  }
  
} 
