resource "azurerm_resource_group" "rgdetails" {
  count    = 10
  name     = "demo-rg-0${count.index+1}"
  location = var.location
}
