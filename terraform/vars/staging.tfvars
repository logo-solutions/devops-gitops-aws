project_name = "takione"

environment = "staging"

aws_main_region = "eu-west-3"

aws_secondary_region = "eu-west-1"

cluster_size = 3

cluster_instance_type = "t3.xlarge"

cluster_version = "1.24"

cidr = "10.20.0.0/16"
private_subnets = ["10.20.2.0/23", "10.20.4.0/23", "10.20.6.0/23" ]
public_subnets = ["10.20.11.0/24", "10.20.12.0/24", "10.20.13.0/24"]

backups_enabled = true
