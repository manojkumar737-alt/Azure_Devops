virtual_networks = {
  vnet1 = {
    name                = "vnet1"
    resource_group_name = "ManojRG"
    location            = "central india"
    address_space       = ["10.0.0.0/16"]
  }
  vnet2 = {
    name                = "vnet2"
    resource_group_name = "ManojRG1"
    location            = "central india"
    address_space       = ["10.1.0.0/16"]
  }
}