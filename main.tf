resource "azurerm_resource_group" "rgdetails" {
  for_each = toset(["dev", "prod", "stage"])
  name     = "${each.value}-rg"
  location = var.location
}
