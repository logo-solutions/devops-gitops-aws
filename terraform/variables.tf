variable "project_name" {
  type    = string
  default = "takione"
}

variable "environment" {
  type    = string
}

variable "aws_main_region" {
  type    = string
  default = "eu-west-3"
}

variable "aws_secondary_region" {
  type    = string
  default = "eu-west-1"
}

variable "cluster_size" {
  type    = number
  default = 2
}

variable "cluster_instance_type" {
  type    = string
  default = "t3.xlarge"
}

variable "cluster_version" {
  default     = "1.24"
  description = "Kubernetes version"
}

variable "cidr" {
  type    = string
  default = "10.2.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.2.2.0/23", "10.2.4.0/23", "10.2.6.0/23" ]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24"]
}

variable "backups_enabled" {
  type = bool
  default = true
}

variable "secrets_enabled" {
  type = bool
  default = true
}

variable "managed_cluster_names" {
  type = list(string)
  default = []
}
