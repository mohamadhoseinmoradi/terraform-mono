resource "aws_instance" "EC2" {
  #provider                    = aws.region-main
  count                       = var.instance-count
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  subnet_id                   = aws_subnet.subnet_1.id

  tags = {
    Name = "EC2-${count.index + 1}"
  }

  depends_on = [aws_main_route_table_association.set-main-default-rt-assoc]
}