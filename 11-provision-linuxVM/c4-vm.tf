#resource azure linux VM

resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  name = "mylinux-1"
  computer_name = "devlinux-1" #hostname
  resource_group_name = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  size = "Standard_DS1_v2"
  admin_username = "admin123"
  network_interface_ids = [
    azurerm_network_interface.munvinterface.id
    
    
  ]

  
  admin_ssh_key {
    username = "admin123"
    public_key = file("${path.module}/ssh-key/terraform-azure.pub")
  }
  os_disk {
    name = "osdisk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }

  custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")
}