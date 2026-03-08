resource "azurerm_resource_group" "rgdetails" {
  name     = "demo-rg-01"
  location = "eastus"
}
resource "azurerm_resource_group" "rgdetails2" {
  name     = "demo-rg-02"
  location = "westus"
}
resource "azurerm_resource_group" "rgdetails3" {
  name     = "demo-rg-03"
  location = "centralus"
}
resource "azurerm_resource_group" "rgdetails4" {
  name     = "demo-rg-04"
  location = "eastus2"
}
resource "azurerm_resource_group" "rgdetails5" {
  name     = "demo-rg-05"
  location = "westus2" 
}
