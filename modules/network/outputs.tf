output "web_subnet_id" {
  value = azurerm_subnet.web.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}

output "web_nsg_id" {
  value = azurerm_network_security_group.web_nsg.id
}

output "db_nsg_id" {
  value = azurerm_network_security_group.db_nsg.id
}