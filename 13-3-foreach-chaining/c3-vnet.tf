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
  #count = 2
  #name = "mypublicip-${count.index}"
  for_each = toset(["vm1","vm2"])
  name = "mypublicip-${each.key}"
    #add resource explicit dependency to have this resource created only after virtual network  and subnet is created
    depends_on = [ 
      azurerm_virtual_network.myvnet,
      azurerm_subnet.mysubnet,
      azurerm_network_security_group.mysg
     ]
    
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    allocation_method = "Static"
    domain_name_label = "app1-vm-${each.key}-${random_string.myrandom.id}"
    tags = {
      "environment" = "Dev" 
    }
    
}


resource "azurerm_network_security_group" "mysg" {
  #count = 2
  for_each = toset(["vm1","vm2"])
  name = "mysng-${each.key}"
  location = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  
}

resource "azurerm_network_security_rule" "mysgrule" {
    #count = 2 
    for_each = toset(["vm1","vm2"])
    name = "mysngrule-${each.key}"
    network_security_group_name = azurerm_network_security_group.mysg[each.key].name
    resource_group_name = azurerm_resource_group.rg1.name
  
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"

    
  
}

resource "azurerm_network_interface_security_group_association" "myngsgassoc" {
  #count = 2
  for_each = toset(["vm1","vm2"])
  
  network_interface_id = azurerm_network_interface.munvinterface[each.key].id
  network_security_group_id = azurerm_network_security_group.mysg[each.key].id
  
}

#resources : create Network interface
resource "azurerm_network_interface" "munvinterface" {
  #count = 2
  for_each = toset(["vm1","vm2"])
  name = "vmnic-${each.key}"
  location = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  

  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = azurerm_public_ip.mypublicip.id
    #public_ip_address_id = azurerm_public_ip.mypublicip[count.index].id
    public_ip_address_id = azurerm_public_ip.mypublicip[each.key].id
  }

  
}



