provider "aws" {
  access_key = local.aws_auth.access-key
  secret_key = local.aws_auth.secret-key
  region     = var.aws_region
}