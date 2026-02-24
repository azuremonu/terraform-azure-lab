/*
resource "azurerm_resource_group" "rgdetails" {
  name     = "rg-monu"
  location = "West US 2"    # ← Ye karo
}
#Storage account
resource "azurerm_storage_account" "storagedetails" {
  count                    = 5
  name                     = "${count.index}terrastrgacnt00111"
  resource_group_name      = azurerm_resource_group.rgdetails.name
  location                 = azurerm_resource_group.rgdetails.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
*/

/*
variable "resource_group" {
   type = map(object({
    resource_group_name = string
    location            = string
    storage_account_name = string
    blob_container_name = string
    }))
  default = {
    "rg1"={
      resource_group_name="rg-test1"
      location="east us"
      storage_account_name = "stmonukr89690001"
      blob_container_name = "data"
    },
    "rg2"={
      resource_group_name="rg-test2"
      location="west us"
      storage_account_name = "stmonukr896990002"
      blob_container_name = "file"
    },
    "rg3"={
      resource_group_name="rg-test3"
      location="central us"
      storage_account_name = "stmonukr89690003"
      blob_container_name = "logs"
    }
  }
}
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group
  name     =   each.value.resource_group_name
  location =   each.value.location
}
resource "azurerm_storage_account" "storage" {
  for_each = var.resource_group
  name                     = each.value.storage_account_name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.rg ]
}
resource "azurerm_storage_container" "blob" {
  for_each = var.resource_group
  name                  = each.value.blob_container_name
  storage_account_name  = each.value.storage_account_name
  container_access_type = "blob"

  depends_on = [ azurerm_storage_account.storage ]
}
*/

data azurerm_resource_group "rgdetails" {
  name = "data-rg"
}
resource azurerm_virtual_network "vnetdetails" {
  name                = "data-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name
}
resource azurerm_subnet "private_subnet" {
  name                 = "data-subnet"
  resource_group_name  = data.azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource azurerm_subnet "public_subnet" {
  name                 = "data-public-subnet"
  resource_group_name  = data.azurerm_resource_group.rgdetails.name
  virtual_network_name = azurerm_virtual_network.vnetdetails.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource azurerm_network_security_group "nsgdetails" { 
  name                = "data-nsg"
  location            = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name
}
resource azurerm_network_security_rule "nsg_rule" { 
  name                        = "data-nsg-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rgdetails.name
  network_security_group_name = azurerm_network_security_group.nsgdetails.name
}
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.nsgdetails.id
}
resource azurerm_public_ip "public_ip_details" {
  name                = "data-public-ip"
  location            = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
resource azurerm_network_interface "nic_details" {
  name                = "data-nic"
  location            = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name

  ip_configuration {
    name                          = "data-ip-config"
    subnet_id                     = azurerm_subnet.private_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_details.id
  }
}
resource azurerm_linux_virtual_machine "vm_details" {
  name                = "data-vm"
  location            = data.azurerm_resource_group.rgdetails.location
  resource_group_name = data.azurerm_resource_group.rgdetails.name
  network_interface_ids = [
    azurerm_network_interface.nic_details.id,
  ]
  size               = "Standard_DS1_v2"
  admin_username     = "azureuser"
  admin_password     = "P@ssw0rd1234!"
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
resource azurerm_managed_disk "data_disk" {
  name                 = "data-disk"
  location             = data.azurerm_resource_group.rgdetails.location
  resource_group_name  = data.azurerm_resource_group.rgdetails.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}
resource azurerm_virtual_machine_data_disk_attachment "data_disk_attachment" {
  virtual_machine_id = azurerm_linux_virtual_machine.vm_details.id
  managed_disk_id   = azurerm_managed_disk.data_disk.id
  lun               = 0
  caching           = "ReadWrite"
}