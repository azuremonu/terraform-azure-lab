resource "azurerm_resource_group" "rg" {
  name = "${var.env_name}-rg"
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name = "${var.env_name}-vnet"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [var.vnet_address_space]
}
resource "azurerm_subnet" "subnet" {
  name = "${var.env_name}-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.subnet_prefix]
}
resource "azurerm_network_security_group" "nsg" {
  name = "${var.env_name}-nsg"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}