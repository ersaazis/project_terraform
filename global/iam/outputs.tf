output "serial_console_instance_profile_name" {
  description = "Name of the shared instance profile for Serial Console access"
  value       = aws_iam_instance_profile.serial_console.name
}

output "serial_console_role_arn" {
  description = "ARN of the shared role for Serial Console access"
  value       = aws_iam_role.serial_console.arn
}
