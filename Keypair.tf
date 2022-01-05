# Create key-pair for logging into EC2 in us-east-1
resource "aws_key_pair" "master-key" {
  provider   = aws.region-main
  key_name   = "my_key"
  public_key = file("/root/.ssh/id_rsa.pub")
}