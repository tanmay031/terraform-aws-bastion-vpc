# main.tf

provider "aws" {
  region  = var.region
  profile = var.profile
}

module "vpc" {
  source = "./vpc"
}

module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
  bastion_sg_name = "bastion-sg"
  private_sg_name = "private-sg"
}

module "keypair" {
  source   = "./keypair"
  key_name = var.key_name
}

module "ec2" {
  source             = "./ec2"
  ami_id             = var.ami_id
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  key_name           = module.keypair.key_name
  bastion_sg_id      = module.security.bastion_sg_id
  private_sg_id      = module.security.private_sg_id
}
