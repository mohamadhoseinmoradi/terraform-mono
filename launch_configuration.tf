resource "aws_launch_configuration" "web-launch" {
  name_prefix = "WEB-"
  image_id      = var.ami_id
  instance_type = var.instance_typee

  security_groups             = [aws_security_group.ec2-sg.id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}