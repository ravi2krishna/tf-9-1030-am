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

# Web Network Secuirty Group
resource "azurerm_network_security_group" "tf-ecomm-web-nsg" {
  name                = "websecuirtyrule"
  location            = azurerm_resource_group.tf-ecomm.location
  resource_group_name = azurerm_resource_group.tf-ecomm.name

  security_rule {
    name                       = "ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Database Network Secuirty Group
resource "azurerm_network_security_group" "tf-ecomm-db-nsg" {
  name                = "dbsecuirtyrule"
  location            = azurerm_resource_group.tf-ecomm.location
  resource_group_name = azurerm_resource_group.tf-ecomm.name

  security_rule {
    name                       = "ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "postgre"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Web Subnet - Web NSG
resource "azurerm_subnet_network_security_group_association" "tf-ecomm-web-sn-nsg" {
  subnet_id                 = azurerm_subnet.tf-ecomm-web-sn.id
  network_security_group_id = azurerm_network_security_group.tf-ecomm-web-nsg.id
}


