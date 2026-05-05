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
terraform {
  backend "azurerm" {
    use_cli              = true                                    # Can also be set via `ARM_USE_CLI` environment variable.
    storage_account_name = "mkstor4wzcbn"                              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "prod.terraform.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"`
    resource_group_name  = "mkrg-resources"
  }
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

