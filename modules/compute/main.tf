
##### CONFIGURATION FOR THE WEB-VM NIC ########
resource "azurerm_network_interface" "web" {
  count               = 2
  name                = "web-nic-${count.index}"
  location            = var.resource_location
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

##### CONFIGURATION FOR THE DB-VM NIC ########
resource "azurerm_network_interface" "db" {
  name                = "db-nic"
  location            = var.resource_location
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.db_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

##### CONFIGURATION FOR THE WEB-TIER VM AVAILABILITY SET ########
resource "azurerm_availability_set" "web" {
  name                = "web-avset"
  location            = var.resource_location
  resource_group_name = var.resource_group
  managed             = true
}

##### CONFIGURATION FOR THE WEB VM ########
resource "azurerm_virtual_machine" "web" {
  count                 = 2
  name                  = "web-vm-${count.index}"
  location              = var.resource_location
  resource_group_name   = var.resource_group
  network_interface_ids = [element(azurerm_network_interface.web.*.id, count.index)]
  vm_size               = "Standard_D2s_v3"
  availability_set_id   = azurerm_availability_set.web.id

  storage_os_disk {
    name              = "web-os-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 128
  }

  os_profile {
    computer_name  = "web-host${count.index}"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {}

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

##### CONFIGURATION FOR THE DB VM ########
resource "azurerm_virtual_machine" "db" {
  name                  = "db-vm"
  location              = var.resource_location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.db.id]
  vm_size               = "Standard_D4s_v3"

  storage_os_disk {
    name              = "db-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
  }

  os_profile {
    computer_name  = "db-host"
    admin_username = "adminuser"
    admin_password = var.admin_password
  }

  os_profile_windows_config {}

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

