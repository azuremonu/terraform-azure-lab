resource "azurerm_resource_group" "rgdetails" {
  name     = "rg-monu"
  location = "East US"
}
resource "azurerm_virtual_network" "vnetdetails" {
  name                = "terra-network"
  location            = azurerm_resource_group.rgdetails.location
  resource_group_name = azurerm_resource_group.rgdetails.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
resource "azurerm_subnet" "subnet1details" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "subnet2details" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_interface" "nicdetails" {
  name                = "terra-nic"
  location            = azurerm_resource_group.rgdetails.location
  resource_group_name = azurerm_resource_group.rgdetails.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1details.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pubipdetails.id
  }
}
resource "azurerm_public_ip" "pubipdetails" {
  name                = "terra_pub_ip"
  resource_group_name = azurerm_resource_group.rgdetails.name
  location            = azurerm_resource_group.rgdetails.location
  allocation_method   = "Static"
}
resource "azurerm_network_security_group" "nsgdetails" {
  name                = "terra-nsg"
  location            = azurerm_resource_group.rgdetails.location
  resource_group_name = azurerm_resource_group.rgdetails.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# Virtual Machine
resource "azurerm_linux_virtual_machine" "vmdetails" {
  name                            = "terra-vm"
  resource_group_name             = azurerm_resource_group.rgdetails.name
  location                        = azurerm_resource_group.rgdetails.location
  size                            = "Standard_DS1_v2"
  admin_username                  = "adminuser"
  admin_password                  = "Admin@12345678"
  disable_password_authentication = false   # ← Password allow karo

  network_interface_ids = [
    azurerm_network_interface.nicdetails.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}