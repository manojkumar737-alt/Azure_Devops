network_interfaces = {

  nic1 = {
    nic_name            = "nic-vm1"
    resource_group_name = "ManojRG"
    location            = "central india"
    vnet_name           = "vnet1"
    subnet_name         = "subnet1"
    tags       = {
        environment = "dev"
        owner       = "krishna"
        }
  }

  nic2 = {
    nic_name            = "nic-vm2"
    resource_group_name = "ManojRG1"
    location            = "central india"
    vnet_name           = "vnet2"
    subnet_name         = "subnet2"
    tags       = {
        environment = "prod"
        owner       = "krishna"
        } 
  }
}