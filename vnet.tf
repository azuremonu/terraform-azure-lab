resource "azurerm_virtual_network" "vnetdetails" {
  name                = "demo-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name
}
resource "azurerm_subnet" "subnetdetails" {
  for_each = var.subnet
  name                 = each.value.name
  resource_group_name  = data.azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = each.value.address_prefixes
}