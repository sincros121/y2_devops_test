variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
}

variable "node_groups" {
  type        = any
  description = "List of node group objects"
}

variable "private_subnets" {
  type = list(string)
  description = "Private subnet ids for EKS node groups to use"
}
