#input variable

#1.business unit name
variable "business_unit" {
    description = "Business Unit Name"
    type = string
    default = "hr"
  
}

#2.environment name

variable "environment" {
    description = "Environment Name"
    type = string
    default = "dev"
  
}
#resource group name
variable "resource_group_name" {
    description = "resource group name"
    type = string
    default = "myrg"
  
}

#4.resource group location
variable "resource_group_location" {
    description = "resource group location"
    type = string
    default = "East US"
  
}

#5.virtual network name
variable "virtual_network_name" {
    description = "virtual network name"
    type = string
    default = "Myvnet"
  
}


#6.subnet name
#7.public ip name
#8.network interface name
#9. virtual machine name
#10. vm os disk name