

provider "aws" {
  alias   = "main"
  region  = var.aws_main_region
}

provider "aws" {
  alias  = "secondary"
  region = var.aws_secondary_region
}

