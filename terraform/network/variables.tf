
variable "region" {
    default     = "eu-west-3"
    description = "AWS region"
}

variable "cluster_name" {}

variable "cidr" {

  type    = string
  default = "10.40.0.0/16"

}

variable "private_subnets" {
  type    = list
  default = ["10.40.2.0/23", "10.40.4.0/23", "10.40.6.0/23" ]
}

variable "public_subnets" {
  type    = list
  default = ["10.40.11.0/24", "10.40.12.0/24", "10.40.13.0/24"]
}

