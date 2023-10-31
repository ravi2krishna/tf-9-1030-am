# Resource Group
resource "azurerm_resource_group" "tf-ecomm" {
  name     = "ecomm-rg"
  location = "East Us"
  tags = {
    env = "dev"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "tf-ecomm-vnet" {
  name                = "ecomm-network"
  location            = azurerm_resource_group.tf-ecomm.location
  resource_group_name = azurerm_resource_group.tf-ecomm.name
  address_space       = ["10.0.0.0/16"]
}

# Web Subnet
resource "azurerm_subnet" "tf-ecomm-web-sn" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.tf-ecomm.name
  virtual_network_name = azurerm_virtual_network.tf-ecomm-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Database Subnet
resource "azurerm_subnet" "tf-ecomm-db-sn" {
  name                 = "database-subnet"
  resource_group_name  = azurerm_resource_group.tf-ecomm.name
  virtual_network_name = azurerm_virtual_network.tf-ecomm-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
