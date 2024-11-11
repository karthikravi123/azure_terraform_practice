resource "azurerm_resource_group" "myrg" {
    #name = "my-rg1"
    #name = var.resource_group_name
    #to append name
    #name = ${var.resource_group_name}-rc1
    name = "${var.business_unit}-${var.environment}-${var.resource_group_name}"
    location = var.resource_group_location
  
}