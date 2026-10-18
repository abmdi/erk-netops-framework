hcl
provider "aws" {
  region = var.region
}

resource "aws_ec2_transit_gateway" "tgw" {
  description = "Main Transit Gateway for inter-VPC communication"
  amazon_side_asn = var.amazon_side_asn

  tags = {
    Name = "Main-Transit-Gateway"
  }
}

resource "aws_ec2_transit_gateway_route_table" "tgw_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "Main-TGW-Route-Table"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachment" {
  count = length(var.vpc_ids)

  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = element(var.vpc_ids, count.index)
  subnet_ids         = element(var.subnet_ids, count.index)

  tags = {
    Name = "VPC-Attachment-${count.index}"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_route_table_association" {
  count = length(var.vpc_ids)

  transit_gateway_attachment_id = element(aws_ec2_transit_gateway_vpc_attachment.vpc_attachment[*].id, count.index)
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_route_table.id
}

resource "aws_ec2_transit_gateway_route" "tgw_route" {
  count = length(var.destination_cidrs)

  destination_cidr_block         = element(var.destination_cidrs, count.index)
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_route_table.id
  transit_gateway_attachment_id  = element(aws_ec2_transit_gateway_vpc_attachment.vpc_attachment[*].id, count.index)
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-west-2"
}

variable "amazon_side_asn" {
  description = "The ASN for the Amazon side of the gateway"
  type        = number
  default     = 64512
}

variable "vpc_ids" {
  description = "List of VPC IDs to attach to the Transit Gateway"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs within the VPCs for Transit Gateway attachment"
  type        = list(list(string))
}

variable "destination_cidrs" {
  description = "List of CIDR blocks for routing through the Transit Gateway"
  type        = list(string)
}
