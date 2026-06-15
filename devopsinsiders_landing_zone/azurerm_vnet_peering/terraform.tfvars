virtual_network_peerings = {

  peering1 = {
    peering_name                 = "vnet1-to-vnet2"
    resource_group_name          = "ManojRG"
    virtual_network_name         = "vnet1"

    remote_virtual_network_name  = "vnet2"
    remote_resource_group_name   = "ManojRG1"

    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  peering2 = {
    peering_name                 = "vnet2-to-vnet1"
    resource_group_name          = "ManojRG1"
    virtual_network_name         = "vnet2"

    remote_virtual_network_name  = "vnet1"
    remote_resource_group_name   = "ManojRG"

    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}