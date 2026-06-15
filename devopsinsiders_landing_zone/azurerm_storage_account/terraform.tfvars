storage_accounts = {
    sa1 = {
      name                     = "syncstorageaccountxxxyyy"
      resource_group_name      = "ManojRG"
      location                 = "central india"
      account_tier             = "Standard"
      account_replication_type = "LRS"
      tags = {
        environment = "dev"
        owner       = "krishna"
      }
    },
    sa2 = {
      name                     = "syncstorageaccountxyyy2"
      resource_group_name      = "ManojRG1"
      location                 = "central india"
      account_tier             = "Standard"
      account_replication_type = "LRS"
      tags = {
        environment = "prod"
        owner       = "krishna"
      }
     }
    }