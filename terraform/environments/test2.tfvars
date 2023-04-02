#########
# Global
#########
env    = "test2"
region = "us-east-1"


######
# VPC
######
vpc_cidr           = "10.0.0.0/16"
private_subnets    = ["10.1.0.0/22", "10.1.4.0/22"]
public_subnets     = ["10.1.16.0/22", "10.1.20.0/22"]
availability_zones = ["us-east-1a", "us-east-1b"]
enable_nat_gateway = true
enable_igw         = true


######
# EKS
######
eks_enabled     = true
cluster_version = "1.25"
node_groups = [
  {
    name                     = "Default"
    node_group_min_size      = 1
    node_group_desired_size  = 1
    node_group_max_size      = 5
    node_group_instance_type = ["t3.small"]
    disk_size                = 20
    capacity_type            = "SPOT" # SPOT or ON_DEMAND
    ami_type                 = "AL2_x86_64"
    taints = [
      {
        key    = "taint-test",
        value  = "true",
        effect = "NO_SCHEDULE"
      }
    ]
    labels = {
      instance = "t3.small"
    }
  }
]