module "dev" {
  source ="./modules/environment"
  env_name = "dev"
  location = "eastus"
  vnet_address_space = "10.1.0.0/16"
  subnet_prefix = "10.1.0.0/24"
  storage_account_name = "devstoragelab0018969"
}
module "prod" {
  source ="./modules/environment"
  env_name = "prod"
  location = "eastus"
  vnet_address_space = "10.2.0.0/16"
  subnet_prefix = "10.2.0.0/24"
  storage_account_name = "prodstoragelab0018969"
}
module "staging" {
  source ="./modules/environment"
  env_name = "staging"
  location = "eastus"
  vnet_address_space = "10.3.0.0/16"
  subnet_prefix = "10.3.0.0/24"
  storage_account_name = "stagingstoragelab0018969"
}