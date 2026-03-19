module "vpc" {
  source = "../../../../modules/vpc"

  vpc_name             = "database-vpc"
  vpc_cidr             = "10.31.0.0/16"
  private_subnet_cidrs = ["10.31.1.0/24"]
  availability_zones   = ["us-west-2a"]
}

module "ec2" {
  source = "../../../../modules/ec2"

  instance_name    = "database-node"
  instance_type    = "t3.micro"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.private_subnet_ids[0]
  ami_id            = var.ami_id
  ssh_allowed_cidr    = var.control_vpc_cidr
  icmp_allowed_cidr   = var.control_vpc_cidr
  mysql_allowed_cidrs = [var.control_vpc_cidr, var.app_vpc_cidr]
  key_name            = "secret-key-dev-db-us-west-2"
}
