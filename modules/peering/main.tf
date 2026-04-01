resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.accepter_vpc_id
  vpc_id      = var.requester_vpc_id
  auto_accept = true

  tags = {
    Name = var.peering_name
  }
}

resource "aws_route" "requester" {
  for_each = toset(var.requester_route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter" {
  for_each = toset(var.accepter_route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.requester_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

# ICMP Rules
resource "aws_vpc_security_group_ingress_rule" "requester_icmp" {
  security_group_id = var.requester_security_group_id
  cidr_ipv4         = var.accepter_vpc_cidr
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "accepter_icmp" {
  security_group_id = var.accepter_security_group_id
  cidr_ipv4         = var.requester_vpc_cidr
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

