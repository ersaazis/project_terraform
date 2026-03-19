output "control_to_application_peering_id" {
  description = "ID of the control to application peering connection"
  value       = module.control_to_application.peering_connection_id
}

output "control_to_database_peering_id" {
  description = "ID of the control to database peering connection"
  value       = module.control_to_database.peering_connection_id
}
