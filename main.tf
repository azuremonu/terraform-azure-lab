module "dev" {
  source = "./modules/base_infrastructure"
  env_name = "dev"
  location = "eastus"
  vnet_address_space = "10.1.0.0/16"
  subnet_prefix = "10.1.0.0/24"
  storage_account_name = "devstoragelab0018969"
}
module "prod" {
  source = "./modules/base_infrastructure"
  env_name = "prod"
  location = "eastus"
  vnet_address_space = "10.2.0.0/16"
  subnet_prefix = "10.2.0.0/24"
  storage_account_name = "prodstoragelab0018969"    
}
module "stage" {
  source = "./modules/base_infrastructure"
  env_name = "stage"
  location = "eastus"   
  vnet_address_space = "10.3.0.0/16"
  subnet_prefix = "10.3.0.0/24"
  storage_account_name = "stagingstoragelab0018969"
}

module "dev_database" {
  source              = "./modules/database"
  env_name            = "dev"
  location            = "eastus"
  resource_group_name = module.dev.resource_group_name
  vnet_name           = module.dev.vnet_name
  db_subnet_prefix    = "10.1.1.0/24"
  sql_admin_username  = "sqladmin"
  sql_admin_password  = "P@ssword1234!"
  backup_storage_name = "devdbbackup0018969"
}

module "prod_database" {
  source              = "./modules/database"
  env_name            = "prod"
  location            = "eastus"
  resource_group_name = module.prod.resource_group_name
  vnet_name           = module.prod.vnet_name
  db_subnet_prefix    = "10.2.1.0/24"
  sql_admin_username  = "sqladmin"
  sql_admin_password  = "P@ssword1234!"
  backup_storage_name = "proddbbackup0018969"
}

module "stage_database" {
  source              = "./modules/database"
  env_name            = "stage"
  location            = "eastus"
  resource_group_name = module.stage.resource_group_name
  vnet_name           = module.stage.vnet_name
  db_subnet_prefix    = "10.3.1.0/24"
  sql_admin_username  = "sqladmin"
  sql_admin_password  = "P@ssword1234!"
  backup_storage_name = "stagedbbackup0018969"
}