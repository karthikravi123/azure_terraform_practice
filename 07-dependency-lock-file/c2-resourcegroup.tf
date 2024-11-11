#create resource group in east us -default provider

resource "azurerm_resource_group" "rg1" {
  name = "rg-1"
  location = "East US"
  
}

#Resource-2 :Random string
#terraform provide - random
resource "random_string" "myrandom" {
  length = 16
  special = false
  upper = false
}

#Resource-3 Azure storage account

resource "azurerm_storage_account" "mmys" {
  name = "mmys${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  account_tier = "Standard"
  account_replication_type = "GRS"
  tags = {
    "key" = "stagging" 
  }
  
 # Disable soft delete for blob storage
  blob_properties {
    
  }
  



  


  
}