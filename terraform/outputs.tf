
output "cluster_id" {
  description = "ID of EKS cluster"
  value       = module.compute.cluster_id
}

output "cluster_name" {
  description = "Name of EKS cluster"
  value       = module.compute.cluster_name
}

output "cluster_certificate_authority_data" {
  description = "Certificate data of EKS cluster"
  value       = module.compute.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.compute.cluster_endpoint
}

output "ansible_vars" {
  value = jsonencode(yamldecode(
    templatefile("templates/ansible_vars.yaml.tftpl", {
      compute = module.compute,
      backup = one(module.backups[*]),
      secrets = one(module.secrets[*]),
      managed_resources = module.managed_resources,
    })
  ))
  sensitive = true
  description = "Output Ansible variables"
}
