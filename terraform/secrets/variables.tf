variable "environment" {
  type = string
  description = "Environment for which to create backup content"
  nullable = false
}

variable "project_name" {
  type = string
  description = "Project name to use as iam prefix"
  nullable = false
}

variable "region" {
  type = string
  description = "Main region where to store secrets"
  nullable = false
}
