resource "aws_ecs_task_definition" "socks_web_app" {
  container_definitions    = file("orders.json")
  family                   = var.appName
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "socks_web_app" {
  name            = "${var.appName}_${var.environ}"
  cluster         = aws_ecs_cluster.socks_web_app.id
  task_definition = aws_ecs_task_definition.socks_web_app.arn
  launch_type     = "EC2"

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}

resource "aws_ecs_cluster" "socks_web_app" {
  name = "socks_web_app"
}


resource "aws_launch_configuration" "ecs_cluster" {
  name                        = "${var.appName}_cluster_conf_${var.environ}"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ecs.id
  image_id                    = lookup(var.ami, var.aws_region)
  instance_type               = "t3.medium"
  security_groups             = [
    aws_security_group.allow_all_outbound.id,
    aws_security_group.allow_cluster.id,
  ]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.socks_web_app.name} > /etc/ecs/ecs.config"
}

resource "aws_autoscaling_group" "ecs_cluster" {
  name                 = "${var.appName}_${var.environ}"
  vpc_zone_identifier  = module.vpc.public_subnets
  min_size             = 3
  max_size             = 4
  desired_capacity     = 3
  launch_configuration = aws_launch_configuration.ecs_cluster.name
  health_check_type    = "EC2"
}