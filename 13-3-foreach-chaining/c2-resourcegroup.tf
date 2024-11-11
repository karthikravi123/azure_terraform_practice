#create resource group in east us -default provider

resource "azurerm_resource_group" "rg1" {
  name = "rg-1"
  location = "East US"
  
}

