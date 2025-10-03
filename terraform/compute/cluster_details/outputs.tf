output "cluster_id" {
  description = "EKS cluster ID."
  value       = data.aws_eks_cluster.cluster.id
}

output "cluster_name" {
  description = "EKS cluster Name."
  value       = data.aws_eks_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = data.aws_eks_cluster.cluster.endpoint
}

output "cluster_region" {
  description = "EKS cluster Region"
  value       = data.aws_arn.cluster.region
}

output "cluster_certificate_authority_data" {
  description = "Cluster certificate"
  value       = data.aws_eks_cluster.cluster.certificate_authority[0].data
}

output "cluster_kubeconfig" {
  value = jsonencode(yamldecode(
    templatefile("${path.module}/templates/kubeconfig.yaml.tftpl", {
      certificate_data = data.aws_eks_cluster.cluster.certificate_authority[0].data,
      cluster_name = data.aws_eks_cluster.cluster.name,
      cluster_endpoint = data.aws_eks_cluster.cluster.endpoint,
      account_id = data.aws_caller_identity.current.account_id,
      region_code = data.aws_arn.cluster.region,
    })
  ))
  description = "Output Cluster Kubeconfig"
}
