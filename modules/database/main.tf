resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.env_name}-db-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  address_prefixes = [var.db_subnet_prefix]
}
resource "azurerm_network_security_group" "db_nsg" {
  name                = "${var.env_name}-db-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SQL"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}
resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.env_name}-sql-server"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}
resource "azurerm_mssql_database" "sql_db" {
  name      = "${var.env_name}-sqldb"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S0"
}