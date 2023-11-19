resource "aws_security_group" "allow_all_outbound" {
  name_prefix = "${var.appName}-${var.environ}-${module.vpc.vpc_id}-"
  description = "Allow all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_all_inbound" {
  name_prefix = "${var.appName}-${var.environ}-${module.vpc.vpc_id}-"
  description = "Allow all inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_cluster" {
  name_prefix = "${var.appName}-${var.environ}-${module.vpc.vpc_id}-"
  description = "Allow all traffic within cluster"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}