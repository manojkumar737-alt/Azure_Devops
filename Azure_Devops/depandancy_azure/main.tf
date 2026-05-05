#want to practice of depandancies in terraform
terraform{
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version= "4.69.0"
			}
		}
}

#configure the azure providers
provider "azurerm" {
	features {}
}
resource "random_string" "sa" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "mk_rg" {
  name     = "mkrg-resources"
  location = "West Europe"
}
##### using explicit depandancy ####

resource "azurerm_storage_account" "mk_sa4" {
  name = "mkstor${random_string.sa.result}"
  resource_group_name      = "mkrg-resources"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on = [
    azurerm_resource_group.mk_rg
  ]
}