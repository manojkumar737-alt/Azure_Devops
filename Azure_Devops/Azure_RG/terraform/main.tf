resource "azurerm_resource_group" "mk_rg_terraform" {
	name = var.resource_group_name
	location = var.resource_group_location
	tags = {
		Managedby = "terraform"
	}
}
