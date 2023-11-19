variable "environ" { default = "demo" }
variable "appName" { default = "socks-shop" }
variable "aws_region" { default = "eu-central-1" }
variable "aws_region_full" { default = "eu-central-1a" }

variable "ami" {
  description = "AWS ECS AMI id"
  default     = {
    eu-central-1   = "ami-0e8f6957a4eb67446"
  }
}