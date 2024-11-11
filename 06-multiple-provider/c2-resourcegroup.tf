#create resource group in east us -default provider

resource "azurerm_resource_group" "rg1" {
  name = "rg-11"
  location = "East US"
  
}

#create resource group in west us provider

resource "azurerm_resource_group" "rg2" {
  name = "rg-2"
  location = "West US"
  provider = azurerm.provider2-westus
}