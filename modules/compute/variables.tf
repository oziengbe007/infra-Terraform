variable "resource_location" {
  type = string
  description = "varible for location of the vm"
}

variable "resource_group" {
  type = string
  description = "resource group name where the vm will reside"
}

variable "web_subnet_id" {
    type = string
    description = "ID of the subnet to attach the network interface to"
}

variable "db_subnet_id" {
  type = string
  description = "value"
}

variable "admin_password" {
    type = string
}