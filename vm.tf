# Virtual Machine
resource "azurerm_linux_virtual_machine" "tf-ecomm-web-vm" {
  name                = "ecomm-server"
  resource_group_name = azurerm_resource_group.tf-ecomm.name
  location            = azurerm_resource_group.tf-ecomm.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  custom_data         = filebase64("ecomm.sh")
  network_interface_ids = [
    azurerm_network_interface.tf-ecomm-web-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
