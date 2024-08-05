
variable "resource_group" {
  type = string
  description = "resource group for the project"
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

variable "kv_sku_name" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "admin_object_id" {
  type = string
}