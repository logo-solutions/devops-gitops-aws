variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_subnets" {
  description = "A list of subnet IDs where the nodes/node groups will be provisioned"
  type        = list(string)
}

variable "instance_types" {
    default = ["t3.xlarge"]
}


variable "cluster_size" {
  type = number
}

variable "region" {
    default     = "eu-west-3"
    description = "AWS region"
}

variable "cluster_version" {
  default     = "1.24"
  description = "Kubernetes version"
}

variable "agent_namespace" {
  default     = "gitlab-agent"
  description = "Kubernetes namespace to install the Agent"
}
