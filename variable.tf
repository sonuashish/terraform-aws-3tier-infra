variable "instance_type" { type = list(string) }
variable "instance_name" { type = list(string) }

variable "cidr_block" { type = string }
variable "public_subnet_cidr_block" { type = list(string) }
variable "private_subnet_cidr_block" { type = list(string) }

variable "enable_dns_hostnames" { type = bool }
variable "enable_dns_support" { type = bool }
