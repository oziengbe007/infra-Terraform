resource "azurerm_public_ip" "lb-ip" {
  name                = "lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "main" {
  name                = "main-lb"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.lb-ip.id
  }
}
resource "azurerm_lb_backend_address_pool" "main" {
    loadbalancer_id = azurerm_lb.main.id
    name            = "backend-pool"
}
resource "azurerm_lb_probe" "main" {
    loadbalancer_id = azurerm_lb.main.id
    name            = "http-probe"
    protocol        = "Http"
    port            = 80
    request_path    = "/"
    interval_in_seconds = 5
    number_of_probes    = 2
}

resource "azurerm_lb_rule" "main" {
    loadbalancer_id                         = azurerm_lb.main.id
    name                                    = "http-rule"
    protocol                                = "Tcp"
    frontend_ip_configuration_name          = "frontend"
    frontend_port                           = 80
    backend_port                            = 80
    backend_address_pool_ids                 = [azurerm_lb_backend_address_pool.main.id]
    probe_id                                = azurerm_lb_probe.main.id
}

