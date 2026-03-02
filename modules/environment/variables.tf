variable "env_name" {
  type = string
  description = "Environment name e.g. dev, prod, staging"
}
variable "location" {
  type = string
  description = "Azure Region where Azure resources will be created"
  default = "eastus"
}
variable "vnet_address_space" {
  type = string
  description = "IP range for the Virtual Network e.g. 10.1.0.0/16"
}
variable "subnet_prefix" {
  type = string
  description = "IP range for the Subnet e.g. 10.1.1.0/24"
}
variable "storage_account_name" {
  type = string
  description = "Must be globally unique, lowercase, no hyphens, max 24 chars"
}