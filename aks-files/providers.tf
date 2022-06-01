# Configureer de Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# In de required_providers block kunnen we de source & version meegeven
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.39.0"
    }
  }
}