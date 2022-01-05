
# Create VPC in main-region
resource "aws_vpc" "main_vpc" {
  provider             = aws.region-main
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "main-vpc"
    Terraformed = "True"
  }

}

#Create IGW in main-region
resource "aws_internet_gateway" "igw" {
  provider = aws.region-main
  vpc_id   = aws_vpc.main_vpc.id
  tags = {
    Name        = "main_VPC_IGW"
    Terraformed = "True"
  }
}

# Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  provider = aws.region-main
  state    = "available"
}


# Create subnet #1 in region-main
resource "aws_subnet" "subnet_1" {
  provider          = aws.region-main
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "Subnet_1"
  }
}


# Create subnet #2  in region-main
resource "aws_subnet" "subnet_2" {
  provider          = aws.region-main
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "Subnet_2"
  }
}

# Create subnet #3  in region-main
resource "aws_subnet" "subnet_3" {
  provider          = aws.region-main
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = element(data.aws_availability_zones.azs.names, 2)
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "Subnet_3"
  }
}

# Create route table in us-east-1
resource "aws_route_table" "internet_route" {
  provider = aws.region-main
  vpc_id   = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "region-main-RT"
  }
}

# Overwrite default route table of VPC(Master) with our route table entries
resource "aws_main_route_table_association" "set-main-default-rt-assoc" {
  provider       = aws.region-main
  vpc_id         = aws_vpc.main_vpc.id
  route_table_id = aws_route_table.internet_route.id
}