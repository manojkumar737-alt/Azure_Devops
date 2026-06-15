bastion_hosts = {
  bastion1 = {
    bastion_name          = "bastion-host-dev"
    resource_group_name   = "rg1"
    location              = "eastus"
    ip_configuration_name = "bastion-ip-config-1"

    subnet_id = "/subscriptions/04243f73-ed5c-459f-984d-f2b31368bd14/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/AzureBastionSubnet"

    public_ip_address_id = "/subscriptions/04243f73-ed5c-459f-984d-f2b31368bd14/resourceGroups/rg1/providers/Microsoft.Network/publicIPAddresses/pip-bastion-dev"
  }

  bastion2 = {
    bastion_name          = "bastion-host-prod"
    resource_group_name   = "rg2"
    location              = "eastus2"
    ip_configuration_name = "bastion-ip-config-2"

    subnet_id = "/subscriptions/04243f73-ed5c-459f-984d-f2b31368bd14/resourceGroups/rg2/providers/Microsoft.Network/virtualNetworks/vnet2/subnets/AzureBastionSubnet"

    public_ip_address_id = "/subscriptions/04243f73-ed5c-459f-984d-f2b31368bd14/resourceGroups/rg2/providers/Microsoft.Network/publicIPAddresses/pip-bastion-prod"
  }
}