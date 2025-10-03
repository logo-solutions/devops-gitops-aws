terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=4.58"
      configuration_aliases = [aws.main]
    }
  }
  required_version = ">= 1.4"
}


// Terraform AWS current account id
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "backup" {
  name = "${var.name}-${var.environment}"
  path = "/"
}

resource "aws_iam_access_key" "backup" {
  user    = aws_iam_user.backup.name
}

// Access to putting objects in all s3 buckets starting with db-*
resource "aws_iam_user_policy" "backup_backup_policy" {
  name        = "FrogGeneratedDbBackupReadWrite"
  user = aws_iam_user.backup.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketTagging",
          "s3:DeleteObjectVersion",
          "s3:GetObjectVersionTagging",
          "s3:ListBucketVersions",
          "s3:GetBucketLogging",
          "s3:RestoreObject",
          "s3:ListBucket",
          "s3:GetBucketPolicy",
          "s3:ReplicateObject",
          "s3:GetObjectAcl",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketObjectLockConfiguration",
          "s3:PutBucketTagging",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectTagging",
          "s3:PutObjectTagging",
          "s3:DeleteObject",
          "s3:DeleteObjectTagging",
          "s3:GetBucketPolicyStatus",
          "s3:ListBucketMultipartUploads",
          "s3:GetObjectRetention",
          "s3:PutObjectVersionTagging",
          "s3:PutJobTagging",
          "s3:DeleteObjectVersionTagging",
          "s3:GetBucketVersioning",
          "s3:GetObjectLegalHold",
          "s3:GetBucketNotification",
          "s3:GetReplicationConfiguration",
          "s3:PutObject",
          "s3:GetObject",
          "s3:PutObjectRetention",
          "s3:GetBucketCORS",
          "s3:GetObjectVersionForReplication",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion"
        ],
        "Resource": [
          "arn:aws:s3:*:${data.aws_caller_identity.current.account_id}:job/*",
          "arn:aws:s3::${data.aws_caller_identity.current.account_id}:accesspoint/*",
          "arn:aws:s3:::db-backup-*",
          "arn:aws:s3:us-west-2:${data.aws_caller_identity.current.account_id}:async-request/mrap/*/*",
          "arn:aws:s3:*:${data.aws_caller_identity.current.account_id}:storage-lens/*",
          "arn:aws:s3:::*/*",
          "arn:aws:s3-object-lambda:*:${data.aws_caller_identity.current.account_id}:accesspoint/*"
        ]
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "s3:ListAllMyBuckets",
        "Resource": "*"
      }
    ]
  })
}
