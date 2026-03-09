

module "prod_rg" {
  source = "./modules/resource_group"
  name="prod_rg"
}
module "stage_rg" {
  source = "./modules/resource_group"
  name="stage_rg"
}
module "dev-rg" {
  source = "./modules/resource_group"
  name = "dev_rg"
}
