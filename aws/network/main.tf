# Get the public IP address of my console for creating a ssh rule in security group
data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
}

# Get AZ info in the region
data "aws_availability_zones" "available" {}

# Create VPC
resource "aws_vpc" "vpc-poc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns

  tags = {
    Name = "vpc-${var.project_name}"
  }
}

# Create subnets
resource "aws_subnet" "subnets" {
  count                   = var.vpc_subnet_count
  vpc_id                  = aws_vpc.vpc-poc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = var.enable_dns
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "subnet-${count.index}"
  }
}

# Create security group that only allow ssh from my host IP
resource "aws_security_group" "sg-vpc-poc" {
  name = "${var.project_name}-sg"
  vpc_id = aws_vpc.vpc-poc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.my_public_ip.response_body)}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
    Name = "var.project_name"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "poc-igw" {
  vpc_id = aws_vpc.vpc-poc.id

  tags = {
    Name = "vpc-${var.project_name}"
  }
}

# Create a route table
resource "aws_route_table" "poc-route-table" {
  vpc_id = aws_vpc.vpc-poc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.poc-igw.id
  }

  tags = {
    Name = "vpc-${var.project_name}"
  }
}

# Associate the route table to these subnets
resource "aws_route_table_association" "poc-route-table-association" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.poc-route-table.id
}