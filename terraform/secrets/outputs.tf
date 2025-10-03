
output "name" {
  value = aws_iam_user.secrets.name
  description = "AWS User to read Secrets in K8S"
}

output "aws_access_key_id" {
  value = aws_iam_access_key.secrets.id
  description = "AWS AccessKeyID to read Secrets in K8S"
}

output "aws_secret_access_key" {
  value = aws_iam_access_key.secrets.secret
  description = "AWS AccessKeySecret to read Secrets in K8S"
  sensitive = true
}

output "region" {
  value = var.region
  description = "AWS Main region"
}
