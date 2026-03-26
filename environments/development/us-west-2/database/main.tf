module "vpc" {
  source = "../../../../modules/vpc"

  vpc_name             = "development-database-vpc"
  vpc_cidr             = "10.32.0.0/16"
  public_subnet_cidrs  = ["10.32.0.0/24"]
  private_subnet_cidrs = ["10.32.1.0/24"]
  availability_zones   = ["us-west-2a"]
  enable_nat_gateway   = true
}

module "ec2" {
  source = "../../../../modules/ec2"

  instance_name    = "development-database-node"
  instance_type    = "t3.micro"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.private_subnet_ids[0]
  ami_id            = var.ami_id
  ssh_allowed_cidr     = try(data.terraform_remote_state.control.outputs.vpc_cidr, "10.11.0.0/16")
  key_name             = "secret-key-dev-db-us-west-2"
  iam_instance_profile = data.terraform_remote_state.iam.outputs.serial_console_instance_profile_name
}
