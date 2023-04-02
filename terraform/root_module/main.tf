###################################
# Provision Network infrastructure
###################################
module "network" {
  source = "../modules/network"

  env    = var.env
  region = var.region

  # VPC Configuration
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_igw         = var.enable_igw
}


########################################
# Provision EKS cluster and node groups
########################################
module "eks" {
  source = "../modules/eks"
  count  = var.eks_enabled ? 1 : 0

  env    = var.env
  region = var.region

  # Cluster Configuration
  cluster_version = var.cluster_version
  node_groups     = var.node_groups

  # Network Configuration
  private_subnets = module.network.private_subnets

  depends_on = [
    module.network
  ]
}