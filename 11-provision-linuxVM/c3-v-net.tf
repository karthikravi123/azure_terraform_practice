#resource-2 create vnet
resource "azurerm_virtual_network" "myvnet" {
    name = "my-net1"
    address_space = [ "10.0.0.0/16" ]
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    tags = {
      "Name" = "my-vnet-1" 
    }
}


#resource 3 -create subnet
resource "azurerm_subnet" "mysubnet" {
    name = "mysubnet-1"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes = [ "10.0.2.0/24" ]
  
}

#resource 4- create public ip address
resource "azurerm_public_ip" "mypublicip" {
    #add resource explicit dependency to have this resource created only after virtual network  and subnet is created
    depends_on = [ 
      azurerm_virtual_network.myvnet,
      azurerm_subnet.mysubnet
     ]
    name = "mypublicip-1"
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    allocation_method = "Static"
    domain_name_label = "app1-vm-${random_string.myrandom.id}"
    tags = {
      "environment" = "Dev" 
    }
  
}




#resources : create Network interface
resource "azurerm_network_interface" "munvinterface" {
  name = "vmnic"
  location = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id
  }
}



