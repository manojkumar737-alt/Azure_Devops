nsgs = {
  nsg1 = {
    nsg_name            = "web-nsg"
    resource_group_name = "ManojRG"
    location            = "central india"
    vnet_name           = "vnet1"
    subnet_name         = "subnet1"
  }

  nsg2 = {
    nsg_name            = "app-nsg"
    resource_group_name = "ManojRG1"
    location            = "central india"
    vnet_name           = "vnet2"
    subnet_name         = "subnet2"
  }
}