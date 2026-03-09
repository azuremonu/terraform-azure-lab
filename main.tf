

module "prod_rg" {
  source = "./modules/resource_group"
  name="prod_rg"
  location = "japaneast"
}
module "stage_rg" {
  source = "./modules/resource_group"
  name="stage_rg"
  location = "brazilsouth"
}
module "dev-rg" {
  source = "./modules/resource_group"
  name = "dev_rg"
  location = "centralindia"
}
