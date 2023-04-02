#########################################
# EKS IAM roles, polices and attachements
#########################################
locals {
  policies_path = "${path.module}/assume_role_policies"
}

# Role creation for the cluster and for each node group
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role-${var.env}-${var.region}"
  assume_role_policy = file("${local.policies_path}/eks-assume-role.json")
}

resource "aws_iam_role" "eks_node_group_role" {
  count = length(var.node_groups)

  name               = "${var.node_groups[count.index].name}-node-group-role-${var.env}-${var.region}"
  assume_role_policy = file("${local.policies_path}/eks-assume-role-nodes.json")
}


# Required AWS managed EKS cluster policy attachments
resource "aws_iam_role_policy_attachment" "eks_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = resource.aws_iam_role.eks_cluster_role.name
  depends_on = [resource.aws_iam_role.eks_cluster_role]
}

resource "aws_iam_role_policy_attachment" "eks_controller_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = resource.aws_iam_role.eks_cluster_role.name
  depends_on = [resource.aws_iam_role.eks_cluster_role]
}

# Required AWS managed node groups policy attachments
resource "aws_iam_role_policy_attachment" "eks_worker_node_role_policy_attachment" {
  count = length(var.node_groups)

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = resource.aws_iam_role.eks_node_group_role[count.index].name
  depends_on = [aws_iam_role.eks_node_group_role]
}

resource "aws_iam_role_policy_attachment" "eks_registry_role_policy_attachment" {
  count = length(var.node_groups)

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = resource.aws_iam_role.eks_node_group_role[count.index].name
  depends_on = [aws_iam_role.eks_node_group_role]
}

resource "aws_iam_role_policy_attachment" "eks_cni_node_role_policy_attachment" {
  count = length(var.node_groups)

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = resource.aws_iam_role.eks_node_group_role[count.index].name
  depends_on = [aws_iam_role.eks_node_group_role]
}