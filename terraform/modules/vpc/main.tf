hcl
provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "internet_access" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones to deploy the resources"
  type = list(string)
}
