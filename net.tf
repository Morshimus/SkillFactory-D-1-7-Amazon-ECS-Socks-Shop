module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name = "${var.appName}-${var.environ}-vpc"
  version = "~> 3.0"

  azs = [var.aws_region_full]
  cidr = "10.100.0.0/16"
  public_subnets  = ["10.100.101.0/24"]
}