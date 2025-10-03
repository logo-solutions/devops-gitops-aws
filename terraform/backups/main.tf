terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.58"
      configuration_aliases = [aws.main, aws.secondary]
    }
  }
  required_version = ">= 1.4.0"
}

module "pg_backup" {
  source    = "./s3_bucket"
  providers = {
    aws.main      = aws.main
    aws.secondary = aws.secondary
  }
  name            = "${var.project_name}-pg-backup"
  environment     = var.environment
  replicated      = true
}


module "pg_backup_user" {
  source    = "./iam_user"
  providers = {
    aws.main      = aws.main
  }
  name            = "${var.project_name}-pg-backup"
  environment     = var.environment
}
