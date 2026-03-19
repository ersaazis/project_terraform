module "control_to_application" {
  source = "../../../../modules/peering"

  peering_name = "control-to-application-peering"

  requester_vpc_id          = data.terraform_remote_state.control.outputs.vpc_id
  requester_vpc_cidr        = data.terraform_remote_state.control.outputs.vpc_cidr
  requester_route_table_ids = [data.terraform_remote_state.control.outputs.public_route_table_id]

  accepter_vpc_id          = data.terraform_remote_state.application.outputs.vpc_id
  accepter_vpc_cidr        = data.terraform_remote_state.application.outputs.vpc_cidr
  accepter_route_table_ids = [data.terraform_remote_state.application.outputs.public_route_table_id]
}

module "control_to_database" {
  source = "../../../../modules/peering"

  peering_name = "control-to-database-peering"

  requester_vpc_id          = data.terraform_remote_state.control.outputs.vpc_id
  requester_vpc_cidr        = data.terraform_remote_state.control.outputs.vpc_cidr
  requester_route_table_ids = [data.terraform_remote_state.control.outputs.public_route_table_id]

  accepter_vpc_id          = data.terraform_remote_state.database.outputs.vpc_id
  accepter_vpc_cidr        = data.terraform_remote_state.database.outputs.vpc_cidr
  accepter_route_table_ids = data.terraform_remote_state.database.outputs.public_route_table_id != null ? [data.terraform_remote_state.database.outputs.public_route_table_id] : []
}
