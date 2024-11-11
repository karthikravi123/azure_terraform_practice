#create resource group in east us -default provider

resource "azurerm_resource_group" "rg1" {
  count = 3
  name = "rg-${count.index}"
  location = "East US"
  
}

