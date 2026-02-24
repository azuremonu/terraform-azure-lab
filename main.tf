/*
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
*/

variable "resource_group" {
   type = map(object({
    resource_group_name = string
    location            = string
  }))
  default = {
    "rg1"={
      resource_group_name="rg-test1"
      location="east us"
    },
    "rg2"={
      resource_group_name="rg-test2"
      location="west us"
    },
    "rg3"={
      resource_group_name="rg-test3"
      location="central us"
    }
  }
}
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group
  name     =   each.value.resource_group_name
  location =   each.value.location
}