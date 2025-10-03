variable "environment" {
  type = string
  description = "Environment for which to create a replicated s3 bucket"
  nullable = false
}

variable "name" {
  type = string
  description = "Name prefix for the replicated s3"
  nullable = false
}

variable "replicated" {
  type = bool
  default = false
  description = "Is s3 bucket replicated or not"
}

variable "versioned" {
  type = bool
  default = true
  description = "Is s3 bucket versioned or not"
}

variable "encrypted" {
  type = bool
  default = false
  description = "Is s3 bucket encryption enabled or not"
}
