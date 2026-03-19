output "key_names" {
  description = "Map of key names"
  value       = { for k, v in aws_key_pair.this : k => v.key_name }
}

output "private_key_paths" {
  description = "Map of private key paths"
  value       = { for k, v in local_file.private_key : k => v.filename }
}
