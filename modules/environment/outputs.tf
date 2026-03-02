# Exposes the Resource Group name so other modules can reference it
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of the created resource group"
}

# Exposes VNet name - useful if another module needs to peer networks
output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of the created virtual network"
}

# Exposes Storage name - useful for applications that need to connect to it
output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Name of the created storage account"
}