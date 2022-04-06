
terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = ">= 2.80.0"
  }
}

provider "azurerm" {
  features {}
}
