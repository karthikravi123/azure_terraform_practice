#terraform Settings Block

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      #version = "4.6.0"
    }
  }
}


#Configure the microsoft azure provider
provider "azurerm" {
  
  subscription_id = "cd01b5e8-67e6-4bef-b369-b732b28abc63"
  # Configuration options
  features {
    
  }
  use_cli = true


}

#Create resource group

resource "azurerm_resource_group" "myrg1" {
    location = "eastus"
    name = "myrg1"
  
}
