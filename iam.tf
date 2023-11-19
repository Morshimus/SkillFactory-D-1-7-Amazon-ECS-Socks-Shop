# This role has a trust relationship which allows
# to assume the role of ec2
resource "aws_iam_role" "ecs" {
  name = "${var.appName}_ecs_${var.environ}"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

# This is a policy attachement for the "ecs" role, it provides access
# to the the ECS service.
resource "aws_iam_policy_attachment" "ecs_for_ec2" {
  name = "${var.appName}_${var.environ}"
  roles = [aws_iam_role.ecs.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


resource "aws_iam_instance_profile" "ecs" {
  name = "${var.appName}_${var.environ}"
  role = aws_iam_role.ecs.name
}