
##### resoiurce group.  ####

resource "azurerm_resource_group" "rg" {
  name     = "rg-vnet-practice"
  location = "eastus"
}

##### vnet, subnet1, subnet2, subnet3  ####
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-practice"
  address_space       = ["10.0.0.0/16"]
  location = "eastus"
  resource_group_name = azurerm_resource_group.rg.name
}   

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet_QA"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
    name                = "subnet_dev"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes    = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet3" {
    name                = "subnet_prod"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes    = ["10.0.3.0/24"]
}

##### storage account  ####
resource "azurerm_storage_account" "storage" {
  name                     = "stpracticestorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

terraform {
  backend "azurerm" {
    use_cli              = true
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "mkterraformstate1fx9xu"
    container_name       = "tfstate"
    key                  = "vnet-practice.tfstate"
  }
}


