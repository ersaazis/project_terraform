output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "serial_console_password" {
  description = "The generated password for the default OS user for serial console access"
  value       = random_password.serial_console.result
  sensitive   = true
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.this.id
}
