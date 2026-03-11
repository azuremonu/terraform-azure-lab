# Infra createion for Dev Environment

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
  sql_server_name     = "dev-sqlserver-monu9999"
  location            = "centralus"
  resource_group_name = module.resource_group.name
  db_name             = "dev-db"
  admin_login         = "sqladmin"
  admin_password      = "P@ssword1234!"
  tags                = { environment = "dev" }
}

# Infra createion for Prod Environment
module "prod_resource_group" {
  source   = "./modules/resource_group"
  name     = "prod-rg"
  location = "eastus2"
  tags     = { environment = "prod" }
}

module "prod_vnet" {
  source              = "./modules/vnet"
  vnet_name           = "prod-vnet"
  location            = module.prod_resource_group.location
  resource_group_name = module.prod_resource_group.name
  address_space       = ["10.2.0.0/16"]
  subnet_name         = "prod-subnet"
  subnet_prefix       = "10.2.1.0/24"
  nsg_name            = "prod-nsg"
  tags                = { environment = "prod" }
}

module "prod_storage" {
  source               = "./modules/storage"
  storage_account_name = "prodstgmonu2024"
  location             = module.prod_resource_group.location
  resource_group_name  = module.prod_resource_group.name
  container_name       = "prod-container"
  blob_name            = "prod-blob.txt"
  tags                 = { environment = "prod" }
}

module "prod_vm" {
  source              = "./modules/vm"
  vm_name             = "prod-vm"
  location            = module.prod_resource_group.location
  resource_group_name = module.prod_resource_group.name
  subnet_id           = module.prod_vnet.subnet_id
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"
  tags                = { environment = "prod" }
}

module "prod_database" {
  source              = "./modules/database"
  sql_server_name     = "prod-sqlserver-monu2024"
  location            = "centralus"
  resource_group_name = module.prod_resource_group.name
  db_name             = "prod-db"
  admin_login         = "sqladmin"
  admin_password      = "P@ssword1234!"
  tags                = { environment = "prod" }
}