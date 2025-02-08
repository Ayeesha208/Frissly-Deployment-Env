resource "aws_vpc" "vpc" {
    cidr_block       = var.vpc_id
    instance_tenancy = var.instance_tenancy
    enable_dns_support = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    
    tags = {
        Name = "Dev-vpc"
    }
}

resource "aws_subnet" "public_01" {
  vpc_id            = aws_vpc.vpc.id  # Replace with your VPC ID
  cidr_block        = var.public_subnet_01   # Replace with your desired CIDR block
  availability_zone = var.availability_zone # Replace with your desired Availability Zone
  map_public_ip_on_launch = var.map_public_ip_on_launch           # Enable auto-assign public IP

  # Optional: Assign tags to your subnets
  tags = {
    Name = "Dev-Public-Subnet-01"
  }
}

resource "aws_subnet" "public_02" {
  vpc_id            = aws_vpc.vpc.id  # Replace with your VPC ID
  cidr_block        = var.public_subnet_02  # Replace with your desired CIDR block
  availability_zone = var.availability_zone1 # Replace with your desired Availability Zone

  # Optional: Assign tags to your subnets
  tags = {
    Name = "Dev-Public-Subnet-02"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  # Optional: Assign tags to your Internet Gateway
  tags = {
    Name = "Dev-Internet-Gateway"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  # Optional: Assign tags to your route table
  tags = {
    Name = "Dev-RouteTable-01"
  }
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.public_01.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.public_02.id
  route_table_id = aws_route_table.rt1.id
}