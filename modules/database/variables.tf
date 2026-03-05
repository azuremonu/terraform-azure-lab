variable "env_name" {
  type        = string
  description = "Environment name e.g. dev, prod, staging"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "Existing RG from base_infrastructure module"
}

variable "vnet_name" {
  type        = string
  description = "Existing VNet from base_infrastructure module"
}

variable "db_subnet_prefix" {
  type        = string
  description = "IP range for DB private subnet e.g. 10.1.1.0/24"
}

variable "sql_admin_username" {
  type        = string
  description = "Administrator username for SQL Server"
}

variable "sql_admin_password" {
  type        = string
  description = "Administrator password for SQL Server"
  sensitive   = true
}

variable "backup_storage_name" {
  type        = string
  description = "Globally unique, lowercase, no hyphens, max 24 chars"
}