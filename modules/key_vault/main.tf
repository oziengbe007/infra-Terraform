
resource "azurerm_key_vault" "main" {
  name                = "devkey99"
  resource_group_name = var.resource_group
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  location            = var.location

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.admin_object_id
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "tenant_id" {
  name         = "tenant-id"
  value        = var.tenant_id
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  value        = var.admin_password
  key_vault_id = azurerm_key_vault.main.id
}
