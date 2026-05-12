variable "variables" {
  type = map(object({
    location = string
    name = string
    manager = string
    managed_by = string
  }))
}
resource "azurerm_resource_group" "for_loop_rg" {
  for_each = var.variables
  name     = each.value.name
  location = each.value.location
  managed_by = each.value.managed_by
  tags = {
	environment = each.key
	lead = each.value.manager
  }
}
