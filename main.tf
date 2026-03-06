resource "azurerm_resource_group" "rgdetails" {
  name     = var.rg_name
  location = var.location   
}
#VNET
resource "azurerm_virtual_network" "vnetdetails" {
  name                = "terra-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgdetails.name
  address_space       = var.address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
#Subnet 1
resource "azurerm_subnet" "subnet1details" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["var.subnet_prefix[0]"]
}
#Subnet 2
resource "azurerm_subnet" "subnet2details" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["var.subnet_prefix[1]"]
}
# Network Interface
resource "azurerm_network_interface" "nicdetails" {
  name                = "terra-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgdetails.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1details.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pubipdetails.id
  }
}
#Public IP
resource "azurerm_public_ip" "pubipdetails" {
  name                = "terra_pub_ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}
#NSG
resource "azurerm_network_security_group" "nsgdetails" {
  name                = "terra-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgdetails.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# Attach NSG to NIC
resource "azurerm_network_interface_security_group_association" "nsglink" {
  network_interface_id = azurerm_network_interface.nicdetails.id
  network_security_group_id = azurerm_network_security_group.nsgdetails.id
}
# Virtual Machine
resource "azurerm_linux_virtual_machine" "vmdetails" {
  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
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
