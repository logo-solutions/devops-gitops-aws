terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=4.58"
      configuration_aliases = [aws.main, aws.secondary]
    }
  }
  required_version = ">= 1.4"
}

resource "aws_iam_role" "replication" {
  provider           = aws.main
  name               = "${var.environment}-iam-role-bucket-${var.name}-replication"
  count              = var.replicated ? 1 : 0
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  provider = aws.main
  name     = "iam-role-policy-bucket-${var.name}-${var.environment}-replication"
  count    = var.replicated ? 1 : 0
  policy   = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
        "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.mirror[0].arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "replication" {
  provider   = aws.main
  count      = var.replicated ? 1 : 0
  role       = aws_iam_role.replication[0].name
  policy_arn = aws_iam_policy.replication[0].arn
}

resource "aws_s3_bucket" "mirror" {
  provider = aws.secondary
  count    = var.replicated ? 1 : 0
  bucket   = "${var.name}-${var.environment}-mirror"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "mirror" {
  provider    = aws.secondary
  bucket = "${var.name}-${var.environment}-mirror"
  depends_on  = [aws_s3_bucket.mirror]
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "mirror" {
  provider    = aws.secondary
  count       = var.replicated ? 1 : 0
  bucket      = "${var.name}-${var.environment}-mirror"
  depends_on  = [aws_s3_bucket_ownership_controls.mirror]
  acl         = "private"
}


resource "aws_s3_bucket_versioning" "mirror" {
  provider = aws.secondary
  count    = var.replicated ? 1 : 0
  bucket   = "${var.name}-${var.environment}-mirror"
  versioning_configuration {
    status = var.versioned ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket" "source" {
  provider        = aws.main
  bucket          = "${var.name}-${var.environment}"
  force_destroy = true
  lifecycle {
  }
}

resource "aws_s3_bucket_ownership_controls" "source" {
  provider        = aws.main
  bucket = "${var.name}-${var.environment}"
  depends_on  = [aws_s3_bucket.source]
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_acl" "source" {
  provider        = aws.main
  bucket          = "${var.name}-${var.environment}"
  depends_on      = [aws_s3_bucket_ownership_controls.source]
  acl             = "private"
  lifecycle {
  }
}

resource "aws_s3_bucket_versioning" "source" {
  provider = aws.main
  bucket   = "${var.name}-${var.environment}"
  versioning_configuration {
    status = var.versioned ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  provider   = aws.main
  count      = var.replicated ? 1 : 0
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source]
  role       = aws_iam_role.replication[0].arn
  bucket     = aws_s3_bucket.source.id

  rule {
    id = "replicate-to-mirror"

    filter {}

    delete_marker_replication {
      status = "Enabled"
    }
    
    status = var.replicated ? "Enabled" : "Disabled"

    destination {
      bucket        = aws_s3_bucket.mirror[0].arn
      storage_class = "STANDARD"
      replication_time {
        status = "Enabled"
        time {
          minutes = 15
        }
      }
      metrics {
        status = "Enabled"
        event_threshold {
          minutes = 15
        }
      }
    }
  }
}

resource "aws_kms_key" "source" {
  provider                = aws.main
  count                   = var.encrypted ? 1 : 0
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  lifecycle {
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "source" {
  bucket = aws_s3_bucket.source.id
  count  = var.encrypted ? 1 : 0
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.source[0].arn
      sse_algorithm     = "aws:kms"
    }
  }
}