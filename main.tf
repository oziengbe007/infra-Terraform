
data "azurerm_client_config" "current" {}

module "key_vault" {
  source = "./modules/key_vault"
  resource_group      = var.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  location = var.location
  kv_sku_name = var.kv_sku_name
  admin_password = var.admin_password
  admin_object_id = var.admin_object_id
}

data "azurerm_key_vault_secret" "admin_password" {
  name = "admin-password"
  key_vault_id = module.key_vault.key_vault_id
}

data "azurerm_key_vault_secret" "tenant_id" {
  name = "tenant-id"
  key_vault_id = module.key_vault.key_vault_id
}

module "compute" {
  source              = "./modules/compute"
  resource_location   = var.location
  resource_group      = var.resource_group
  web_subnet_id       = module.network.web_subnet_id
  db_subnet_id        = module.network.db_subnet_id
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
}

module "network" {
  source                     = "./modules/network"
  location                   = var.location
  resource_group             = var.resource_group
  web_subnet_id              = module.network.web_subnet_id
  db_subnet_id               = module.network.db_subnet_id
  web_subnet_address_prefix  = var.web_subnet_address_prefix
}

module "load_balancer" {
  source = "./modules/load_balancer"
  location            = var.location
  resource_group      = var.resource_group
}

module "app_gateway" {
  source              = "./modules/app_gateway"
  location            = var.location
  resource_group      = var.resource_group
  web_subnet_id       = module.network.web_subnet_id
}

module "database" {
  source = "./modules/database"
  location            = var.location
  resource_group      = var.resource_group
  admin_login         = var.admin_user
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
}

module "backup" {
  source            = "./modules/backup"
  vault_name        = "backupVault"
  policy_name       = "backupPolicy"
  location          = var.location
  resource_group    = var.resource_group
  web_vm_count      = length(module.compute.web_vm_ids)
  web_vm_ids        = module.compute.web_vm_ids
  db_vm_id          = module.compute.db_vm_id
}