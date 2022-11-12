module "vpc" {
  source = "./vpc"
  for_each = var.vpc
  cidr_block = each.value.cidr_block
  subnets    = each.value.subnets
  env = var.env
  AZ = var.AZ
}

module "eks" {
  source = "./eks"
  env = var.env
  PRIVATE_SUBNET_IDS = module.vpc["main"].subnets["apps"].subnet_ids
  PUBLIC_SUBNET_IDS = module.vpc["main"].subnets["public"].subnet_ids
}

output "private" {
  value = module.vpc["main"].subnets["apps"].subnet_ids
}