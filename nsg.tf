/*
resource "azurerm_network_security_group" "nsgdetails" {
  name = "demo-nsg"
  location = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name
}
resource "azurerm_network_security_rule" "demo-nsg-rules" {

  for_each = var.security_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "${each.value.destination_port_range}"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rgdetails.name
  network_security_group_name = azurerm_network_security_group.nsgdetails.name
}
*/