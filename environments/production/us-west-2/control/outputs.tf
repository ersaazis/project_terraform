output "ec2_private_ip" {
  description = "Private IP of the control node"
  value       = module.ec2.private_ip
}

output "ec2_public_ip" {
  description = "Public IP of the control node"
  value       = module.ec2.public_ip
}

output "vpc_cidr" {
  description = "CIDR of the control VPC"
  value       = module.vpc.vpc_cidr
}

output "vpc_id" {
  description = "ID of the control VPC"
  value       = module.vpc.vpc_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.vpc.public_route_table_id
}
