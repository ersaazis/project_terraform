module "control_to_application" {
  source = "../../../../modules/peering"

  peering_name = "mirror-control-to-application-peering"

  requester_vpc_id          = try(data.terraform_remote_state.control.outputs.vpc_id, "")
  requester_vpc_cidr        = try(data.terraform_remote_state.control.outputs.vpc_cidr, "10.11.0.0/16")
  requester_route_table_ids = compact(concat(
    try([data.terraform_remote_state.control.outputs.public_route_table_id], []),
    try(data.terraform_remote_state.control.outputs.private_route_table_ids, [])
  ))

  accepter_vpc_id           = try(data.terraform_remote_state.application.outputs.vpc_id, "")
  accepter_vpc_cidr         = try(data.terraform_remote_state.application.outputs.vpc_cidr, "10.24.0.0/16")
  accepter_route_table_ids  = compact(concat(
    try([data.terraform_remote_state.application.outputs.public_route_table_id], []),
    try(data.terraform_remote_state.application.outputs.private_route_table_ids, [])
  ))
  requester_security_group_id = try(data.terraform_remote_state.control.outputs.security_group_id, "")
  accepter_security_group_id  = try(data.terraform_remote_state.application.outputs.security_group_id, "")
}

module "application_to_database" {
  source = "../../../../modules/peering"

  peering_name = "mirror-application-to-database-peering"

  requester_vpc_id          = try(data.terraform_remote_state.application.outputs.vpc_id, "")
  requester_vpc_cidr        = try(data.terraform_remote_state.application.outputs.vpc_cidr, "10.24.0.0/16")
  requester_route_table_ids = compact(concat(
    try([data.terraform_remote_state.application.outputs.public_route_table_id], []),
    try(data.terraform_remote_state.application.outputs.private_route_table_ids, [])
  ))

  accepter_vpc_id           = try(data.terraform_remote_state.database.outputs.vpc_id, "")
  accepter_vpc_cidr         = try(data.terraform_remote_state.database.outputs.vpc_cidr, "10.34.0.0/16")
  accepter_route_table_ids  = compact(concat(
    try([data.terraform_remote_state.database.outputs.public_route_table_id], []),
    try(data.terraform_remote_state.database.outputs.private_route_table_ids, [])
  ))
  requester_security_group_id = try(data.terraform_remote_state.application.outputs.security_group_id, "")
  accepter_security_group_id  = try(data.terraform_remote_state.database.outputs.security_group_id, "")
  enable_mysql_rules          = true
}

module "control_to_database" {
  source = "../../../../modules/peering"

  peering_name = "mirror-control-to-database-peering"

  requester_vpc_id          = try(data.terraform_remote_state.control.outputs.vpc_id, "")
  requester_vpc_cidr        = try(data.terraform_remote_state.control.outputs.vpc_cidr, "10.11.0.0/16")
  requester_route_table_ids = compact(concat(
    try([data.terraform_remote_state.control.outputs.public_route_table_id], []),
    try(data.terraform_remote_state.control.outputs.private_route_table_ids, [])
  ))

  accepter_vpc_id           = try(data.terraform_remote_state.database.outputs.vpc_id, "")
  accepter_vpc_cidr         = try(data.terraform_remote_state.database.outputs.vpc_cidr, "10.34.0.0/16")
  accepter_route_table_ids  = compact(concat(
    try([data.terraform_remote_state.database.outputs.public_route_table_id], []),
    try(data.terraform_remote_state.database.outputs.private_route_table_ids, [])
  ))
  requester_security_group_id = try(data.terraform_remote_state.control.outputs.security_group_id, "")
  accepter_security_group_id  = try(data.terraform_remote_state.database.outputs.security_group_id, "")
  enable_mysql_rules          = true
}
