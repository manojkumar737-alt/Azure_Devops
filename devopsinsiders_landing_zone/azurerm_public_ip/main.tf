resource "azurerm_public_ip" "public_ip" {
  for_each = var.public_ips

  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allocation_method = each.value.allocation_method
  sku               = each.value.sku

  tags = each.value.tags
}
output "public_ip_ids" {
  value = {
    for k, v in azurerm_public_ip.public_ip :
    k => v.id
  }
}

output "public_ip_addresses" {
  value = {
    for k, v in azurerm_public_ip.public_ip :
    k => v.ip_address
  }
}