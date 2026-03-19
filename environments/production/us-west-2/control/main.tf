module "vpc" {
  source = "../../../../modules/vpc"

  vpc_name            = "control-vpc"
  vpc_cidr            = "10.11.0.0/16"
  public_subnet_cidrs = ["10.11.1.0/24"]
  availability_zones  = ["us-west-2a"]
}

module "ec2" {
  source = "../../../../modules/ec2"

  instance_name    = "control-node"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_ids[0]
  ami_id           = var.ami_id
  ssh_allowed_cidr = var.admin_cidr
  key_name         = var.key_name
}
