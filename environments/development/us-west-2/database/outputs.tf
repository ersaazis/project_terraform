output "ec2_private_ip" {
  description = "Private IP of the database node"
  value       = module.ec2.private_ip
}

output "vpc_cidr" {
  description = "CIDR of the database VPC"
  value       = module.vpc.vpc_cidr
}

output "vpc_id" {
  description = "ID of the database VPC"
  value       = module.vpc.vpc_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_ids" {
  description = "IDs of the private route tables"
  value       = module.vpc.private_route_table_ids
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.ec2.security_group_id
}
