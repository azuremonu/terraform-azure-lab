/*
variable "security_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    destination_port_range     = string
  }))
  default = {
    "rule1" = {
      name                   = "Allow-RDP"
      priority               = 100
      destination_port_range = "3389"
    },
    "rule2" = {
      name                   = "Allow-SSH"
      priority               = 200
      destination_port_range = "22"
    },
    "rule3" = {
      name                   = "Allow-HTTP"
      priority               = 300
      destination_port_range = "80"
    }
    "rule4" = {
      name                   = "Allow-HTTPS"
      priority               = 400
      destination_port_range = "443"
    }
  }
}
variable "subnet" {
    type = map(object({
        name                 = string
        address_prefixes     = list(string)
    }))
    default = {
    "subnet1" = {
        name             = "private-subnet"
        address_prefixes = ["10.0.1.0/24"]
    },
    "subnet2" = {
        name             = "public-subnet"
        address_prefixes = ["10.0.2.0/24"]
    },
    "subnet3" = {
        name             = "dmz-subnet"
        address_prefixes = ["10.0.3.0/24"]
    },
    "subnet4" = {
        name             = "app-subnet"
        address_prefixes = ["10.0.4.0/24"]
    }
    }
    }
    */