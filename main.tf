resource "azurerm_resource_group" "rgdetails" {
  count    = 5
  name     = "demo-rg-${count.index+1}"
  location = var.location
}
