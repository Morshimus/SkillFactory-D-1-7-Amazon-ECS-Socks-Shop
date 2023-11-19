locals {

  aws_auth = jsondecode(file("${path.module}/aws_key.json"))
}