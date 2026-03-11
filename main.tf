module "resource_group" {
  source   = "./modules/resource_group"
  name     = "dev-rg"
  location = "eastus2"
  tags     = { environment = "dev" }
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "dev-vnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = ["10.1.0.0/16"]
  subnet_name         = "dev-subnet"
  subnet_prefix       = "10.1.1.0/24"
  nsg_name            = "dev-nsg"
  tags                = { environment = "dev" }
}

module "storage" {
  source               = "./modules/storage"
  storage_account_name = "devstgmonu2024"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  container_name       = "dev-container"
  blob_name            = "dev-blob.txt"
  tags                 = { environment = "dev" }
}

module "vm" {
  source              = "./modules/vm"
  vm_name             = "dev-vm"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.vnet.subnet_id
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"
  tags                = { environment = "dev" }
}

module "database" {
  source              = "./modules/database"
  sql_server_name     = "dev-sqlserver-monu2024"
  location            = "centralus"
  resource_group_name = module.resource_group.name
  db_name             = "dev-db"
  admin_login         = "sqladmin"
  admin_password      = "P@ssword1234!"
  tags                = { environment = "dev" }
}