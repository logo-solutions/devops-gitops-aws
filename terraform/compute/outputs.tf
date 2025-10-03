output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.cluster_details.cluster_id
}

output "cluster_name" {
  description = "EKS cluster Name."
  value       = module.cluster_details.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.cluster_details.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Cluster certificate"
  value       = module.cluster_details.cluster_certificate_authority_data
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "cluster_kubeconfig" {
  value = module.cluster_details.cluster_kubeconfig
  description = "Output Cluster Kubeconfig"
}
