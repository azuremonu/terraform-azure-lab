variable "vnet_name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "subnets_name" {
  type = string
}
variable "subnets_prefix" {
  type = string
}
variable "nsg_name" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}