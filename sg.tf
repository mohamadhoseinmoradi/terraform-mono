
# Create SG for allowing TCP/22 from any IP
resource "aws_security_group" "ec2-sg" {
  provider    = aws.region-main
  name        = "ec2-sg"
  description = "Allow TCP/22"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}