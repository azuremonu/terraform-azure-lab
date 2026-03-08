resource "azurerm_resource_group" "rgdetails" {
  for_each = toset(["dev", "prod", "stage"])
  name     = "demo-rg-${each.value}"
  location = var.location
}
