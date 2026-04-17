output "ec2_private_ip" {
  description = "Private IP of the application node"
  value       = module.ec2.private_ip
}

output "private_route_table_ids" {
  description = "IDs of the private route tables"
  value       = module.vpc.private_route_table_ids
}

output "vpc_cidr" {
  description = "CIDR of the application VPC"
  value       = module.vpc.vpc_cidr
}

output "vpc_id" {
  description = "ID of the application VPC"
  value       = module.vpc.vpc_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "serial_console_password" {
  description = "The generated password for the default OS user for serial console access"
  value       = module.ec2.serial_console_password
  sensitive   = true
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.ec2.security_group_id
}

output "ec2_public_ip" {
  description = "Public IP of the application node"
  value       = module.ec2.public_ip
}
