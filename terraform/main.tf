locals {
  cluster_name = var.environment
}

module "network" {
  providers = {
    aws = aws.main
  }
  source   = "./network"
  cluster_name = local.cluster_name
  cidr = var.cidr
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
}


module "compute" {
  providers = {
    aws = aws.main
  }
  source = "./compute"
  cluster_name = local.cluster_name
  environment = var.environment
  private_subnets = module.network.private_subnets
  vpc_id = module.network.vpc_id
  cluster_size = var.cluster_size
  cluster_version = var.cluster_version
}

module "backups" {
  providers = {
    aws.main = aws.main
    aws.secondary = aws.secondary
  }
  count  = var.backups_enabled ? 1 : 0
  source = "./backups"
  environment = var.environment
  project_name = var.project_name
}


module "secrets" {
  providers = {
    aws.main = aws.main
  }
  count  = var.secrets_enabled ? 1 : 0
  source = "./secrets"
  environment = var.environment
  project_name = var.project_name
  region = var.aws_main_region
}

module "managed_resources" {
  providers = {
    aws = aws.main
  }
  count  = length(var.managed_cluster_names)
  source = "./compute/cluster_details"
  cluster_name = var.managed_cluster_names[count.index]
}

