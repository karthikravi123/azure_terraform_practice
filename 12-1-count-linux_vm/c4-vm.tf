#resource azure linux VM

resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  count = 2
  name = "mylinux-${count.index}"
  computer_name = "devlinux-${count.index}" #hostname
  resource_group_name = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  size = "Standard_DS1_v2"
  admin_username = "admin123"
  network_interface_ids = [
    element(azurerm_network_interface.munvinterface[*].id, count.index)
    
    
  ]
  

  
  admin_ssh_key {
    username = "admin123"
    public_key = file("${path.module}/ssh-key/terraform-azure.pub")
  }
  os_disk {

    name = "osdisk-${count.index}"
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