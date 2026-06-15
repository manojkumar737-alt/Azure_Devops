data "azurerm_subnet" "subnet" {
  for_each = var.network_interfaces

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}
resource "azurerm_network_interface" "nic" {
  for_each = var.network_interfaces

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = each.value.tags
}
output "nic_ids" {
  value = {
    for k, v in azurerm_network_interface.nic :
    k => v.id
  }
}