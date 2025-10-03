project_name = "takione"

environment = "dev"

aws_main_region = "eu-west-3"

aws_secondary_region = "eu-west-1"

cluster_size = 3

cluster_instance_type = "t2.medium"

cluster_version = "1.24"

cidr = "10.30.0.0/16"
private_subnets = ["10.30.2.0/23", "10.30.4.0/23", "10.30.6.0/23" ]
public_subnets = ["10.30.11.0/24", "10.30.12.0/24", "10.30.13.0/24"]

backups_enabled = true
