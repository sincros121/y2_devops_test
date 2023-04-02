variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "Cidr of the main VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "list of cidrs of the private subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "list of cidrs of the public subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "list of availability zones for the subnets"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable nat gateway creation for the private subnets"
}

variable "enable_igw" {
  type        = bool
  description = "Enable internet gateway creation for the public subnets"
}