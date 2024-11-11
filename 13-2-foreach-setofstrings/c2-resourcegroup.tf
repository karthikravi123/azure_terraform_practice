resource "azurerm_resource_group" "myrg" {
    for_each = toset(["eastus","eastus2","westus"])
    name = "my-rg-${each.value}"
    location = each.key
  
}