provider "aws" {
  region = var.region
}

# Define the Transit Gateway resource
resource "aws_ec2_transit_gateway" "this" {
  description = var.description

  # Set Amazon side ASN for the TGW
  amazon_side_asn = var.amazon_side_asn

  # Enable default route table association
  default_route_table_association = var.default_route_table_association

  # Enable default route table propagation
  default_route_table_propagation = var.default_route_table_propagation

  tags = var.tags
}

# Outputs
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}

output "transit_gateway_arn" {
  description = "The ARN of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.arn
}

# Variables
variable "region" {
  description = "The AWS region to deploy the Transit Gateway"
  type        = string
}

variable "description" {
  description = "Description for the Transit Gateway"
  type        = string
  default     = "Transit Gateway for hybrid network infrastructure"
}

variable "amazon_side_asn" {
  description = "The ASN for the Amazon side of the Transit Gateway"
  type        = number
  default     = 64512
}

variable "default_route_table_association" {
  description = "Whether to enable association with the default route table"
  type        = bool
  default     = true
}

variable "default_route_table_propagation" {
  description = "Whether to enable propagation with the default route table"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to the Transit Gateway"
  type        = map(string)
  default     = {
    Name = "erk-netops-transit-gateway"
  }
}