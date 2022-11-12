module "vpc" {
  source = "./vpc"
  for_each = var.vpc
  cidr_block = each.value.cidr_block
  subnets    = each.value.subnets
  env = var.env
  AZ = var.AZ
}

