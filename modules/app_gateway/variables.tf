variable "location" {
  type = string
  description = "location of the network configuration"
}

variable "resource_group" {
  type = string
  description = "resource group for the project"
}

variable "web_subnet_id" {
  type = string
  description = "The subnet ID for the application gateway"
}