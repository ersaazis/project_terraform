variable "accepter_route_table_ids" {
  description = "List of route table IDs in the accepter VPC"
  type        = list(string)
}

variable "accepter_vpc_cidr" {
  description = "CIDR block of the accepter VPC"
  type        = string
}

variable "accepter_vpc_id" {
  description = "ID of the accepter VPC"
  type        = string
}

variable "peering_name" {
  description = "Name of the peering connection"
  type        = string
}

variable "requester_route_table_ids" {
  description = "List of route table IDs in the requester VPC"
  type        = list(string)
}

variable "requester_vpc_cidr" {
  description = "CIDR block of the requester VPC"
  type        = string
}

variable "requester_vpc_id" {
  description = "ID of the requester VPC"
  type        = string
}

variable "requester_security_group_id" {
  description = "Security group ID of the requester instance"
  type        = string
}

variable "accepter_security_group_id" {
  description = "Security group ID of the accepter instance"
  type        = string
}

variable "enable_mysql_rules" {
  description = "Whether to enable MySQL rules between peered VPCs"
  type        = bool
  default     = false
}
