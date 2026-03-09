resource "azurerm_resource_group" "rgdetails" {
  name = "dev-rg"
  location = var.location
}
resource "azurerm_resource_group" "rgdetails2" {
  name = "prd-rg"
  location = var.location
}
resource "azurerm_resource_group" "rgdetails" {
  name = "stage-rg"
  location = var.location
}