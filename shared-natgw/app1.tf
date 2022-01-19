resource "aws_vpc" "app1" {
  cidr_block = "10.0.0.0/16"
}

variable "app1_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

resource "aws_subnet" "app1-private" {
  count = 2
  vpc_id     = aws_vpc.app1.id
  cidr_block = var.app1_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "App1-Private-AZ${count.index+1}"
  }
}
