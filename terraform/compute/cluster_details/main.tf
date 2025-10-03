terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.58"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_arn" "cluster" {
  arn = data.aws_eks_cluster.cluster.arn
}
