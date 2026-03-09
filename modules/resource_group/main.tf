resource "azurerm_resource_group" "rgdetails1" {
  name = "dev-rg"
  location = var.location
}
resource "azurerm_resource_group" "rgdetails2" {
  name = "prd-rg"
  location = var.location
}
resource "azurerm_resource_group" "rgdetails3" {
  name = "stage-rg"
  location = var.location
}
