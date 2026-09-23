provider "aws" {
  region = var.aws_region
}

resource "aws_ec2_transit_gateway" "example" {
  description = "Example Transit Gateway"
  amazon_side_asn = var.amazon_side_asn

  tags = {
    Name = "Example-Transit-Gateway"
  }
}

resource "aws_ec2_transit_gateway_route_table" "example" {
  transit_gateway_id = aws_ec2_transit_gateway.example.id

  tags = {
    Name = "Example-TGW-Route-Table"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.example.id
  vpc_id             = var.vpc_id

  tags = {
    Name = "Example-TGW-VPC-Attachment"
  }
}

resource "aws_ec2_transit_gateway_route" "example" {
  destination_cidr_block         = var.destination_cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.example.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.example.id
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
}

variable "amazon_side_asn" {
  description = "The ASN for the Amazon side of the transit gateway"
  type        = number
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the transit gateway"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC to attach to the transit gateway"
  type        = string
}

variable "destination_cidr_block" {
  description = "The CIDR block for the destination route"
  type        = string
}