
output "s3_bucket_region" {
  value = aws_s3_bucket.source.region
  description = "AWS S3 Region"
}

output "s3_bucket_id" {
  value = aws_s3_bucket.source.id
  description = "AWS S3 Id"
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.source.arn
  description = "AWS S3 ARN"
}
