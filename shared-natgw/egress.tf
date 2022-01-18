resource "aws_vpc" "egress" {
  cidr_block = "192.168.0.0/16"
}

variable "egress_subnets_public" {
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "egress_subnets_private" {
  default = ["192.168.3.0/24", "192.168.4.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}

resource "aws_subnet" "egress-public" {
  count = 2
  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_subnets_public[count.index]

  tags = {
    Name = "Egress-Public-AZ${count.index+1}"
  }
}

resource "aws_subnet" "egress-private" {
  count = 2
  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_subnets_private[count.index]

  tags = {
    Name = "Egress-Private-AZ${count.index+1}"
  }
}

resource "aws_internet_gateway" "egress" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "Egress-VPC"
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "egress" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.egress-public.*.id[0]
  tags = {
    Name = "Egress-VPC"
  }
  depends_on = [aws_internet_gateway.egress]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.egress.id
  tags = {
    Name = "Egress-Public-RT"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.egress.id
  tags = {
    Name = "Egress-Private-RT"
  }
}

resource "aws_route_table_association" "public-assoc" {
  count = length(aws_subnet.egress-public)
  subnet_id      = aws_subnet.egress-public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-assoc" {
  count = length(aws_subnet.egress-private)
  subnet_id      = aws_subnet.egress-private.*.id[count.index]
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.egress.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.egress.id
}

