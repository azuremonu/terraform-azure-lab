module "my_rg" {
  source = "./modules/resource_group"
  name = "module-test-rg"
  location = "East US"
}