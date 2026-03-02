resource "azurerm_resource_group" "dev-rg" {
  name = "dev-rg"
  location = var.location
}
resource "azurerm_virtual_network" "dev-vnet" {
  name = "dev-vnet"
  location = var.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  address_space = [var.vnet_address_space]
}
resource "azurerm_subnet" "dev-subnet" {
  name = "dev-subnet"
  resource_group_name = azurerm_resource_group.dev-rg.name
  virtual_network_name = azurerm_virtual_network.dev-vnet.name
  address_prefixes = [var.subnet_prefix]
}
resource "azurerm_storage_account" "dev-storage" {
  name = var.storage_account_name
  resource_group_name = azurerm_resource_group.dev-rg.name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}
