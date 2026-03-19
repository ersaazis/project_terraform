module "vpc" {
  source = "../../../../modules/vpc"

  vpc_name            = "application-vpc"
  vpc_cidr            = "10.21.0.0/16"
  public_subnet_cidrs = ["10.21.1.0/24"]
  availability_zones  = ["us-west-2a"]
}

module "ec2" {
  source = "../../../../modules/ec2"

  instance_name    = "application-node"
  instance_type    = "t3.micro"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_ids[0]
  ami_id            = var.ami_id
  ssh_allowed_cidr  = var.control_vpc_cidr
  icmp_allowed_cidr = var.control_vpc_cidr
  key_name          = "secret-key-dev-app-us-west-2"
}
