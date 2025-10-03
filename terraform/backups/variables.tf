variable "environment" {
  type = string
  description = "Environment for which to create backup content"
  nullable = false
}

variable "project_name" {
  type = string
  description = "Project name to use as bucket prefix"
  nullable = false
}
