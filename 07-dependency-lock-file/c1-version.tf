#terraform blovk
terraform {
  #required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">=3.0"
    }
    
  }
}
#provider -1 for EastUS (Default Provider)
#provider block
provider "azurerm" {
    subscription_id = "cd01b5e8-67e6-4bef-b369-b732b28abc63"
    features { }
    #use_cli = true
}



