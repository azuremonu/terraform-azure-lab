resource "azurerm_resource_group" "rgdetails" {
  name     = "rg-monu"
  location = "West US 2"    # ← Ye karo
}
#Storage account

resource "azurerm_storage_account" "storagedetails" {
  count                    = 5
  name                     = "${count.index}terrastrgacnt00111"
  resource_group_name      = azurerm_resource_group.rgdetails.name
  location                 = azurerm_resource_group.rgdetails.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}