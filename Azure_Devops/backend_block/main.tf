#want to practice of depandancies in terraform
terraform{
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version= "4.69.0"
			}
      random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
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

resource "azurerm_resource_group" "backend" {
  name     = "terraform-backend-rg"
  location = "East US"
}

resource "azurerm_storage_account" "backend" {
  name                     = "mkterraformstate1fx9xu"
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backend" {
  name                 = "tfstate"
  storage_account_id   = azurerm_storage_account.backend.id
  container_access_type = "private"
}

### after creating above respouce we can use these resource to configure the backend in terraform block.
## we can also use the output of these resource to configure the backend. 
####but here i am using the hard coded value for backend configuration.
#
# terraform {
#   backend "azurerm" {
#     use_cli              = true
#     resource_group_name  = "terraform-backend-rg"
#     storage_account_name = "mkterraformstate1fx9xu"
#     container_name       = "tfstate"
#     key                  = "vnet-practice.tfstate"
#   }
# }

