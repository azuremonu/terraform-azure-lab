resource "azurerm_resource_group" "rgdetails" {
  count    = 5
  name     = "demo-rg-0${count.index+1}"
  location = var.location
}
