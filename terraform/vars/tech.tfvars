project_name = "takione"

environment = "tech"

aws_main_region = "eu-west-3"

aws_secondary_region = "eu-west-1"

cluster_size = 3

cluster_instance_type = "t3.large"

cluster_version = "1.24"

cidr = "10.40.0.0/16"
private_subnets = ["10.40.2.0/23", "10.40.4.0/23", "10.40.6.0/23"]
public_subnets = ["10.40.11.0/24", "10.40.12.0/24", "10.40.13.0/24"]

backups_enabled = false

managed_cluster_names = ["staging", "prod"]
