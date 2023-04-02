###################################
# EKS and cluster related resources
###################################

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-${var.env}-${var.region}"
  role_arn = resource.aws_iam_role.eks_cluster_role.arn
  version  = var.cluster_version
  vpc_config {
    endpoint_public_access = true
    subnet_ids             = var.private_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    resource.aws_iam_role_policy_attachment.eks_role_policy_attachment,
    resource.aws_iam_role_policy_attachment.eks_controller_role_policy_attachment
  ]
}