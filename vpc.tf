resource "aws_vpc" "vpc_main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "vpc_main-IGW"
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_subnet" "subnet_A" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_A_cidr_block
  tags = {
    Name = "Subnet_A"
  }
}

resource "aws_subnet" "subnet_B" {
  vpc_id            = aws_vpc.vpc_main.id
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  cidr_block        = var.subnet_B_cidr_block
  tags = {
    Name = "Subnet_B"
  }
}

resource "aws_subnet" "subnet_C" {
  vpc_id            = aws_vpc.vpc_main.id
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  cidr_block        = var.subnet_C_cidr_block
  tags = {
    Name = "Subnet_C"
  }
}

resource "aws_route_table" "internet_route" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "vpc_main-route_table"
  }
}

# Overwrite default route table of VPC(Master) with our route table entries
resource "aws_main_route_table_association" "set-main-default-rt-assoc" {
  vpc_id         = aws_vpc.vpc_main.id
  route_table_id = aws_route_table.internet_route.id
}

resource "aws_route_table_association" "my_vpc_sub_A" {
  subnet_id      = aws_subnet.subnet_A.id
  route_table_id = aws_route_table.internet_route.id
}

resource "aws_route_table_association" "my_vpc_sub_B" {
  subnet_id      = aws_subnet.subnet_B.id
  route_table_id = aws_route_table.internet_route.id
}

resource "aws_route_table_association" "my_vpc_sub_C" {
  subnet_id      = aws_subnet.subnet_C.id
  route_table_id = aws_route_table.internet_route.id
}
