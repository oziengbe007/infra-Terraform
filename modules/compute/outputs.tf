# output "resource_group_name" {
#   value = 
# }

# Output the IDs of the web VMs
output "web_vm_ids" {
  value = azurerm_virtual_machine.web[*].id
}

# Output the ID of the db VM
output "db_vm_id" {
  value = azurerm_virtual_machine.db.id
}