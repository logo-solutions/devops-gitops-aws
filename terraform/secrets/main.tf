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


resource "aws_iam_user" "secrets" {
  name = "${var.project_name}-secrets-${var.environment}"
  path = "/"
}

resource "aws_iam_access_key" "secrets" {
  user    = aws_iam_user.secrets.name
}

data "aws_iam_policy" "secrets_read_write" {
  name = "SecretsManagerReadWrite"
}

data "aws_iam_policy" "ssm_read_only" {
  name = "AmazonSSMReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "secrets_attach_ssm_read_only" {
  user       = aws_iam_user.secrets.name
  policy_arn = data.aws_iam_policy.ssm_read_only.arn
}

resource "aws_iam_user_policy_attachment" "secrets_attach_secrets_read_write" {
  user       = aws_iam_user.secrets.name
  policy_arn = data.aws_iam_policy.secrets_read_write.arn
}
