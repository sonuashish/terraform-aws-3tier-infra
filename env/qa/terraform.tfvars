instance_type = ["t3.micro","t3.small","t3.micro"]
instance_name = ["Web-Server","App-Server","Database-Server"]

cidr_block = "10.0.0.0/16"

public_subnet_cidr_block = [
  "10.0.1.0/24"
]

private_subnet_cidr_block = [
  "10.0.2.0/24",
  "10.0.3.0/24"
]




enable_dns_hostnames = true
enable_dns_support   = true
