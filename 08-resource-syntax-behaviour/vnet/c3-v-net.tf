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
    name = "mypublicip-1"
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    allocation_method = "Static"
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