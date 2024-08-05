terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.2"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
  }
}
provider "azurerm" {
  #version = ">=1.2.0"
  features {}
}