resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.address_space
  tags = var.tags
}
resource "azurerm_subnet" "subnet" {
  name = var.subnets_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.subnets_prefix]
}
resource "azurerm_network_security_group" "nsg" {
  name = var.nsg_name
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}
resource "azurerm_network_security_rule" "allow_ssh" {
  name = "Allow-SSH"
  priority = 100
  direction = "Inbound"
  access ="Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
resource "azurerm_subnet_network_security_group_association" "subnet-assoc" {
  subnet_id = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}