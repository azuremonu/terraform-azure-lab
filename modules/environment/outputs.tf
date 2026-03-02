output "resource_group_name" {
  value = azurerm_resource_group.rg.name
  description = "Name of the created resource group"
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
  description = "Name of the created virtual network"
}
output "subnet_name" {
  value = azurerm_subnet.subnet.name
  description = "Name of the created subnet"
}
output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
  description = "Name of the created network security group"
}
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
  description = "Name of the created storage account"
}