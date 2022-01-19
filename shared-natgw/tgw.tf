resource "aws_ec2_transit_gateway" "tgw" {
  description = "TGW-Internet"
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = "TGW-Internet"
  }
}

