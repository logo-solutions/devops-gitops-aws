
output "name" {
  value = aws_iam_user.backup.name
  description = "AWS User for Backups in K8S"
}

output "aws_access_key_id" {
  value = aws_iam_access_key.backup.id
  description = "AWS AccessKeyID for Backups in K8S"
}

output "aws_secret_access_key" {
  value = aws_iam_access_key.backup.secret
  description = "AWS AccessKeySecret for Backups in K8S"
  sensitive = true
}
