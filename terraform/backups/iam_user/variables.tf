variable "environment" {
  type = string
  description = "Environment for which to create backup content"
  nullable = false
}

variable "name" {
  type = string
  description = "name to use as iam prefix"
  nullable = false
}
