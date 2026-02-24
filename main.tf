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
    storage_account_name = string
    blob_container_name = string
    blobfile_name = string
    }))
  default = {
    "rg1"={
      resource_group_name="rg-test1"
      location="east us"
      storage_account_name = "sttest896936001"
      blob_container_name = "data"
      blobfile_name = "C:\\terraform-azure-lab\\data.txt"
    },
    "rg2"={
      resource_group_name="rg-test2"
      location="west us"
      storage_account_name = "sttest896936001"
      blob_container_name = "file"
      blobfile_name = "C:\\terraform-azure-lab\\file.txt"
    },
    "rg3"={
      resource_group_name="rg-test3"
      location="central us"
      storage_account_name = "sttest896936001"
      blob_container_name = "logs"
      blobfile_name = "C:\\terraform-azure-lab\\logs.txt"
    }
  }
}
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group
  name     =   each.value.resource_group_name
  location =   each.value.location
}
resource "azurerm_storage_account" "storage" {
  for_each = var.resource_group
  name                     = each.value.storage_account_name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.rg ]
}
resource "azurerm_storage_container" "blob" {
  for_each = var.resource_group
  name                  = each.value.blob_container_name
  storage_account_name  = each.value.storage_account_name
  container_access_type = "blob"

  depends_on = [ azurerm_storage_account.storage ]
}
resource azurerm_storage_blob "blobfile" {
  for_each = var.resource_group
  name                   = "${each.value.blob_container_name}.txt"
  storage_account_name   = each.value.storage_account_name
  storage_container_name = each.value.blob_container_name
  type                   = "Block"
  source                 = each.value.blobfile_name

  depends_on = [ azurerm_storage_container.blob ]
}