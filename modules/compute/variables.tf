variable "instance_type" {
  type = list(string)
}

variable "instance_name" {
  type = list(string)
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group" {
  type = string
}

variable "env" {
  type = string
}
