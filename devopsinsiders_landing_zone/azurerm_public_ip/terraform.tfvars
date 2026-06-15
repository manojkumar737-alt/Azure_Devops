public_ips = {

  pip1 = {
    public_ip_name      = "pip-vm1"
    resource_group_name = "ManojRG"
    location            = "central india"
    allocation_method   = "Static"
    sku                 = "Standard"

    tags = {
      Environment = "Dev"
      Owner       = "Krishna"
    }
  }

  /* pip2 = {
    public_ip_name      = "pip-vm2"
    resource_group_name = "ManojRG1"
    location            = "central india"
    allocation_method   = "Static"
    sku                 = "Standard"

    tags = {
      Environment = "Prod"
      Owner       = "Krishna"
    } 
  }*/
}