##########################
# EKS Node group resources
##########################

locals {
  # Manual tags for node groups since terraform does not assign default_tags to node groups by default
  tags = {
    Managed-by  = "Terraform"
    Environment = var.env
    Region      = var.region
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  count = length(var.node_groups)

  cluster_name    = resource.aws_eks_cluster.eks_cluster.id
  node_role_arn   = resource.aws_iam_role.eks_node_group_role[count.index].arn
  node_group_name = var.node_groups[count.index].name
  ami_type        = var.node_groups[count.index].ami_type
  disk_size       = var.node_groups[count.index].disk_size
  capacity_type   = var.node_groups[count.index].capacity_type
  instance_types  = var.node_groups[count.index].node_group_instance_type
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = var.node_groups[count.index].node_group_desired_size
    max_size     = var.node_groups[count.index].node_group_max_size
    min_size     = var.node_groups[count.index].node_group_min_size
  }

  dynamic "taint" {
    for_each = length(lookup(var.node_groups[count.index], "taints", {})) == 0 ? [] : var.node_groups[count.index].taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  labels = lookup(var.node_groups[count.index], "labels", null) != null ? var.node_groups[count.index].labels : null


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    resource.aws_iam_role_policy_attachment.eks_worker_node_role_policy_attachment,
    resource.aws_iam_role_policy_attachment.eks_registry_role_policy_attachment,
    resource.aws_iam_role_policy_attachment.eks_cni_node_role_policy_attachment
  ]

  tags = merge(
    local.tags,
    {
      Name = var.node_groups[count.index].name
    },
  )
}