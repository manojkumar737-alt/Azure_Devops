resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion_hosts

  name                = each.value.bastion_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  ip_configuration {
    name                 = each.value.ip_configuration_name
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_address_id
  }
}