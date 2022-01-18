resource "aws_vpc" "app2" {
  cidr_block = "10.1.0.0/16"
}

variable "app2_subnets" {
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

resource "aws_subnet" "app2-private" {
  count = 2
  vpc_id     = aws_vpc.app2.id
  cidr_block = var.app2_subnets[count.index]

  tags = {
    Name = "App2-Private-AZ${count.index+1}"
  }
}
