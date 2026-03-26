module "vpc" {
  source = "../../../../modules/vpc"

  vpc_name            = "production-application-vpc"
  vpc_cidr            = "10.21.0.0/16"
  public_subnet_cidrs  = ["10.21.1.0/24"]
  private_subnet_cidrs = ["10.21.2.0/24"]
  availability_zones  = ["us-west-2a"]
}

module "ec2" {
  source = "../../../../modules/ec2"

  instance_name    = "production-application-node"
  instance_type    = "t3.micro"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_ids[0]
  ami_id            = var.ami_id
  ssh_allowed_cidr     = try(data.terraform_remote_state.control.outputs.vpc_cidr, "10.11.0.0/16")
  http_allowed_cidrs   = ["0.0.0.0/0"]
  https_allowed_cidrs  = ["0.0.0.0/0"]
  key_name             = "secret-key-prod-app-us-west-2"
  iam_instance_profile = data.terraform_remote_state.iam.outputs.serial_console_instance_profile_name
}

locals {
  internal_monitoring_cidrs = [
    try(data.terraform_remote_state.control.outputs.vpc_cidr, "10.11.0.0/16"),
    module.vpc.vpc_cidr, # Production Application (Current)
    try(data.terraform_remote_state.internal["prod-db"].outputs.vpc_cidr, "10.31.0.0/16"),
    try(data.terraform_remote_state.internal["dev-app"].outputs.vpc_cidr, "10.22.0.0/16"),
    try(data.terraform_remote_state.internal["dev-db"].outputs.vpc_cidr, "10.32.0.0/16"),
    try(data.terraform_remote_state.internal["sta-app"].outputs.vpc_cidr, "10.23.0.0/16"),
    try(data.terraform_remote_state.internal["sta-db"].outputs.vpc_cidr, "10.33.0.0/16"),
    try(data.terraform_remote_state.internal["mir-app"].outputs.vpc_cidr, "10.24.0.0/16"),
    try(data.terraform_remote_state.internal["mir-db"].outputs.vpc_cidr, "10.34.0.0/16"),
  ]
}

resource "aws_vpc_security_group_ingress_rule" "monitoring_mimir" {
  for_each          = toset(local.internal_monitoring_cidrs)
  security_group_id = module.ec2.security_group_id
  cidr_ipv4         = each.value
  from_port         = 9009
  ip_protocol       = "tcp"
  to_port           = 9009
  description       = "Allow Mimir from internal network (${each.value})"
}

resource "aws_vpc_security_group_ingress_rule" "monitoring_loki" {
  for_each          = toset(local.internal_monitoring_cidrs)
  security_group_id = module.ec2.security_group_id
  cidr_ipv4         = each.value
  from_port         = 3100
  ip_protocol       = "tcp"
  to_port           = 3100
  description       = "Allow Loki from internal network (${each.value})"
}

resource "aws_vpc_security_group_ingress_rule" "monitoring_tempo" {
  for_each          = toset(local.internal_monitoring_cidrs)
  security_group_id = module.ec2.security_group_id
  cidr_ipv4         = each.value
  from_port         = 4318
  ip_protocol       = "tcp"
  to_port           = 4318
  description       = "Allow Tempo from internal network (${each.value})"
}

resource "aws_vpc_security_group_ingress_rule" "monitoring_pyroscope" {
  for_each          = toset(local.internal_monitoring_cidrs)
  security_group_id = module.ec2.security_group_id
  cidr_ipv4         = each.value
  from_port         = 4040
  ip_protocol       = "tcp"
  to_port           = 4040
  description       = "Allow Pyroscope from internal network (${each.value})"
}
