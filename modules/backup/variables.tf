variable "vault_name" {
  type = string
  description = "The name of the Recovery Services Vault"
}

variable "policy_name" {
  type = string
  description = "The name of the backup policy"
}

variable "location" {
  type = string
  description = "The location for the resources"
}

variable "resource_group" {
  type = string
  description = "The name of the resource group"
}

variable "web_vm_count" {
  type = string
  description = "The number of web VMs"
}

variable "web_vm_ids" {
  type = list(string)
  description = "List of Web VM IDs to be backed up"
}

variable "db_vm_id" {
  type = string
  description = "The ID of the DB VM to be backed up"
}
