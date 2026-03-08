/*
variable "vm_name" {
  type = string
  default ="terra-vm"
}
variable "vm_size" {
  type = string
  default = "Standard_D2ls_v5"
}
variable "admin_username" {
  type = string
  default = "adminuser"
}
variable "admin_password" {
  type = string
  default   = "Admin@12345678"
  sensitive = true
}

variable "rg_name" {
  type = string
  default = "rg-monu"
}
variable "location" {
  type = string
  default = "West US 2"
}
variable "address_space" {
  type = list
  default = ["10.0.0.0/16"]
}
variable "subnet_prefix" {
  type = list
  default = ["10.0.1.0/24","10.0.2.0/24"]
}
*/