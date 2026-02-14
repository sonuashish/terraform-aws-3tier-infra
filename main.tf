module "networking" {
  source = "./modules/networking"

  cidr_block               = var.cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block= var.private_subnet_cidr_block
  enable_dns_hostnames     = var.enable_dns_hostnames
  enable_dns_support       = var.enable_dns_support
  env                      = terraform.workspace
}

module "compute" {
  source = "./modules/compute"

  instance_type = var.instance_type
  instance_name = var.instance_name

  public_subnet_id   = module.networking.public_subnet_ids[0]
  private_subnet_ids = module.networking.private_subnet_ids

  security_group = module.networking.security_group
  env            = terraform.workspace
}
