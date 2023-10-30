# Resource Group
resource "azurerm_resource_group" "tf-ecomm" {
  name     = "ecomm-rg"
  location = "East Us"
  tags = {
    env = "dev"
  }
}
