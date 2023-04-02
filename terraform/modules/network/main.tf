# resource "aws_vpc" "vpc" {
#   cidr_block = var.vpc_cidr

#   tags = {
#     "Name" = "vpc-test-${var.env}-${var.region}"
#   }
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws" # https://github.com/terraform-aws-modules/terraform-aws-vpc
  version = "3.19.0"

  name = "vpc-${var.env}-${var.region}"
  cidr = var.vpc_cidr

  # Set Availability Zones and Subnets
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  azs             = var.availability_zones

  # NAT Gateway
  enable_nat_gateway = var.enable_nat_gateway

  # Internet Gateway
  create_igw           = var.enable_igw
  enable_dns_hostnames = true

}