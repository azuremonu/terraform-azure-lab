variable "name" {
  type = string
  description = "Name of the resource group"
}
variable "location" {
  type = string
  description = "Azure Region"
  default = "East US"
}