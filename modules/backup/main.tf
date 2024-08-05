
resource "azurerm_recovery_services_vault" "backup_vault" {
  name = "backupVault"
  location = var.location
  resource_group_name = var.resource_group
  sku = "Standard"
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = "backupPolicy"
  resource_group_name = var.resource_group
  recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name
  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 7
  }
  retention_weekly {
    count = 5
    weekdays = ["Sunday"]
  }
  retention_monthly {
    count = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
  retention_yearly {
    count    = 10
    weekdays = ["Sunday"]
    weeks    = ["First"]
    months   = ["January"]
  }
}

resource "azurerm_backup_protected_vm" "web_vm_backup" {
  count                = var.web_vm_count
  resource_group_name  = var.resource_group
  recovery_vault_name  = azurerm_recovery_services_vault.backup_vault.name
  source_vm_id         = element(var.web_vm_ids, count.index)
  backup_policy_id     = azurerm_backup_policy_vm.backup_policy.id
}

resource "azurerm_backup_protected_vm" "db_vm_backup" {
  resource_group_name  = var.resource_group
  recovery_vault_name  = azurerm_recovery_services_vault.backup_vault.name
  source_vm_id         = var.db_vm_id
  backup_policy_id     = azurerm_backup_policy_vm.backup_policy.id
}
