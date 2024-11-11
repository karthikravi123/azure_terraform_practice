#terraform block
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
    features { 
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
    use_cli = true
}


resource "random_string" "myrandom" {
  length = 6
  special = false
  upper = false
  numeric = false
}
  
