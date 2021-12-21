@description('Location for all resources.')
param location string = resourceGroup().location

@description('The size of the VM')
param adf_ir_vm_size string = 'Standard_D4s_v3'

@description('Username for the Virtual Machine.')
param adf_ir_vm_admin_username string = 'adsgofastadmin'

@description('Password for the Virtual Machine. The password must be at least 12 characters long and have lower case, upper characters, digit and a special character (Regex match)')
@secure()
param adf_ir_vm_admin_password string

@description('Defines the type of storage account to use for the data lake store')
@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_RAGRS'
])
param os_disk_type_adfir_vm string = 'Standard_LRS'
param adf_ir_onp_vm_name string

@description('Windows Server and SQL Offer')
@allowed([
  'sql2019-ws2019'
  'sql2017-ws2019'
  'SQL2017-WS2016'
  'SQL2016SP1-WS2016'
  'SQL2016SP2-WS2016'
  'SQL2014SP3-WS2012R2'
  'SQL2014SP2-WS2012R2'
])
param imageOffer string = 'sql2019-ws2019'

@description('SQL Server Sku')
@allowed([
  'Standard'
  'Enterprise'
  'SQLDEV'
  'Web'
  'Express'
])
param sqlSku string = 'Standard'

@description('Amount of data disks (1TB each) for SQL Data files')
@minValue(1)
@maxValue(8)
param sqlDataDisksCount int = 1

@description('Amount of data disks (1TB each) for SQL Log files')
@minValue(1)
@maxValue(8)
param sqlLogDisksCount int = 1

@description('SQL Server Workload Type')
@allowed([
  'General'
  'OLTP'
  'DW'
])
param storageWorkloadType string = 'General'

@description('Path for SQL Data files. Please choose drive letter from F to Z, and other drives from A to E are reserved for system')
param dataPath string = 'F:\\SQLData'

@description('Path for SQL Log files. Please choose drive letter from F to Z and different than the one used for SQL data. Drive letter from A to E are reserved for system')
param logPath string = 'G:\\SQLLog'

@description('Name of Azure Bastion resource')
param vnet_name string = 'adsgofast-vnet'

var adf_ir_vm_name_var = take('IR-Az-${uniqueString(resourceGroup().id)}-VM', 15)
var adf_ir_az_network_interface_name_var = '${adf_ir_vm_name_var}NetInt'
var adf_ir_onp_network_interface_name_var = '${adf_ir_onp_vm_name}NetInt'
var dataDisks = {
  createOption: 'empty'
  caching: 'ReadOnly'
  writeAcceleratorEnabled: false
  storageAccountType: 'Premium_LRS'
  diskSizeGB: 1023
}
var diskConfigurationType = 'NEW'
var dataDisksLuns = array(range(0, sqlDataDisksCount))
var logDisksLuns = array(range(sqlDataDisksCount, sqlLogDisksCount))
var tempDbPath = 'D:\\SQLTemp'
var data_subnet_name = 'Data'

resource adf_ir_az_network_interface_name 'Microsoft.Network/networkInterfaces@2019-09-01' = {
  name: adf_ir_az_network_interface_name_var
  location: location
  tags: {
    displayName: adf_ir_az_network_interface_name_var
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_name, data_subnet_name)
          }
        }
      }
    ]
  }
  dependsOn: []
}

resource adf_ir_onp_network_interface_name 'Microsoft.Network/networkInterfaces@2019-09-01' = {
  name: adf_ir_onp_network_interface_name_var
  location: location
  tags: {
    displayName: adf_ir_onp_network_interface_name_var
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_name, data_subnet_name)
          }
        }
      }
    ]
  }
  dependsOn: []
}

resource adf_ir_vm_name 'Microsoft.Compute/virtualMachines@2019-07-01' = {
  name: adf_ir_vm_name_var
  location: location
  tags: {
    displayName: adf_ir_vm_name_var
  }
  properties: {
    hardwareProfile: {
      vmSize: adf_ir_vm_size
    }
    osProfile: {
      computerName: adf_ir_vm_name_var
      adminUsername: adf_ir_vm_admin_username
      adminPassword: adf_ir_vm_admin_password
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${adf_ir_vm_name_var}OsDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: os_disk_type_adfir_vm
        }
        diskSizeGB: 128
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: adf_ir_az_network_interface_name.id
        }
      ]
    }
  }
}

resource adf_ir_onp_vm_name_resource 'Microsoft.Compute/virtualMachines@2019-07-01' = {
  name: adf_ir_onp_vm_name
  location: location
  tags: {
    displayName: adf_ir_onp_vm_name
  }
  properties: {
    hardwareProfile: {
      vmSize: adf_ir_vm_size
    }
    osProfile: {
      computerName: adf_ir_onp_vm_name
      adminUsername: adf_ir_vm_admin_username
      adminPassword: adf_ir_vm_admin_password
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftSQLServer'
        offer: imageOffer
        sku: sqlSku
        version: 'latest'
      }
      osDisk: {
        name: '${adf_ir_onp_vm_name}OsDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: os_disk_type_adfir_vm
        }
        diskSizeGB: 128
      }
      dataDisks: [for j in range(0, (sqlDataDisksCount + sqlLogDisksCount)): {
        lun: j
        createOption: dataDisks.createOption
        caching: ((j >= sqlDataDisksCount) ? 'None' : dataDisks.caching)
        writeAcceleratorEnabled: dataDisks.writeAcceleratorEnabled
        diskSizeGB: dataDisks.diskSizeGB
        managedDisk: {
          storageAccountType: dataDisks.storageAccountType
        }
      }]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: adf_ir_onp_network_interface_name.id
        }
      ]
    }
  }
}

resource Microsoft_SqlVirtualMachine_SqlVirtualMachines_adf_ir_onp_vm_name 'Microsoft.SqlVirtualMachine/SqlVirtualMachines@2017-03-01-preview' = {
  name: adf_ir_onp_vm_name
  location: location
  properties: {
    virtualMachineResourceId: adf_ir_onp_vm_name_resource.id
    sqlManagement: 'Full'
    sqlServerLicenseType: 'PAYG'
    storageConfigurationSettings: {
      diskConfigurationType: diskConfigurationType
      storageWorkloadType: storageWorkloadType
      sqlDataSettings: {
        luns: dataDisksLuns
        defaultFilePath: dataPath
      }
      sqlLogSettings: {
        luns: logDisksLuns
        defaultFilePath: logPath
      }
      sqlTempDbSettings: {
        defaultFilePath: tempDbPath
      }
    }
  }
}
