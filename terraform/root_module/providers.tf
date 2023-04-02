terraform {
  required_version = ">= 1.3.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.29.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Managed-by  = "Terraform"
      Environment = var.env
      Region      = var.region
    }
  }
}