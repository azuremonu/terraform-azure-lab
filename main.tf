resource "azurerm_resource_group" "rgdetails" {
  name     = "rg-monu"
  location = "East US"
}
resource "azurerm_virtual_network" "vnetdetails" {
  name                = "terra-network"
  location            = azurerm_resource_group.rgdetails.location
  resource_group_name = azurerm_resource_group.rgdetails.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
resource "azurerm_subnet" "subnet1details" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "subnet2details" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["10.0.2.0/24"]
}