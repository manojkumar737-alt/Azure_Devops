# Read existing subnets

data "azurerm_subnet" "subnet" {
  for_each = var.nsgs

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

# Create NSGs

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsgs

  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tags = {
    Environment = "Dev"
    Owner       = "Krishna"
  }
}

# Associate NSG with subnet

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = var.nsgs

  subnet_id                 = data.azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}