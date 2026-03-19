resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.accepter_vpc_id
  vpc_id      = var.requester_vpc_id
  auto_accept = true

  tags = {
    Name = var.peering_name
  }
}

resource "aws_route" "requester" {
  count = length(var.requester_route_table_ids)

  route_table_id            = var.requester_route_table_ids[count.index]
  destination_cidr_block     = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter" {
  count = length(var.accepter_route_table_ids)

  route_table_id            = var.accepter_route_table_ids[count.index]
  destination_cidr_block     = var.requester_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
