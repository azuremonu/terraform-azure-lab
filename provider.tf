terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-lab-rg"
    storage_account_name = "tfstatemonu"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}