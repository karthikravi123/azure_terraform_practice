#terraform blovk
terraform {
  #required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.7.0"
    }
  }
}
#provider -1 for EastUS (Default Provider)
#provider block
provider "azurerm" {
    subscription_id = "cd01b5e8-67e6-4bef-b369-b732b28abc63"
    features { }
    use_cli = true
}


#Provider-2 for Westus
provider "azurerm" {
  subscription_id = "cd01b5e8-67e6-4bef-b369-b732b28abc63"

  features {
    virtual_machine {
      delete_os_disk_on_deletion = false
      
    }
  }
  use_cli = true
  #clieclient_id = 
  alias = "provider2-westus"
  
}