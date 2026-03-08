resource "azurerm_resource_group" "rgdetails" {
  for_each = toset(["dev", "prod", "stage"])
  name     = "demo-rg-${for_each.key}"
  location = var.location
}
