# Fetch remote VNets

data "azurerm_virtual_network" "remote_vnet" {
  for_each = var.virtual_network_peerings

  name                = each.value.remote_virtual_network_name
  resource_group_name = each.value.remote_resource_group_name
}

# Create VNet Peerings

resource "azurerm_virtual_network_peering" "vnet_peering" {
  for_each = var.virtual_network_peerings

  name                 = each.value.peering_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name

  remote_virtual_network_id = data.azurerm_virtual_network.remote_vnet[each.key].id

  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_gateway_transit        = each.value.allow_gateway_transit
  use_remote_gateways          = each.value.use_remote_gateways
}