variable "location" {
    type = string
    description = "location of the network configuration"
}

variable "resource_group" {
    type = string
    description = "resource group for the project"
}

variable "web_subnet_address_prefix" {
    description = "The address space for the web subnet"
    type = string
}

variable "web_subnet_id" {
  description = "ID of the web subnet"
  type        = string
}

variable "db_subnet_id" {
  description = "ID of the database subnet"
  type        = string
}