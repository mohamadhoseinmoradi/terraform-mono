resource "aws_autoscaling_group" "web-asg" {
  name                 = "${aws_launch_configuration.web-launch.name}-ASG"
  min_size             = 3
  desired_capacity     = 6
  max_size             = 9
  launch_configuration = aws_launch_configuration.web-launch.name

  tag {
    key                 = "Name"
    value               = "WEB-ASG"
    propagate_at_launch = true
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    aws_subnet.subnet_A.id,
    aws_subnet.subnet_B.id,
    aws_subnet.subnet_C.id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}