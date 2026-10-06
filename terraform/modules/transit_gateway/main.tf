hcl
// Define the AWS provider
provider "aws" {
  region = var.region
}

// Define variables for Transit Gateway configuration
variable "region" {
  description = "The AWS region to deploy the Transit Gateway"
  type        = string
}

variable "tgw_name" {
  description = "Name of the Transit Gateway"
  type        = string
  default     = "example-transit-gateway"
}

variable "asn" {
  description = "The Autonomous System Number (ASN) for the Transit Gateway"
  type        = number
  default     = 64512
}

// Create the Transit Gateway
resource "aws_ec2_transit_gateway" "tg" {
  description = var.tgw_name
  amazon_side_asn = var.asn

  tags = {
    Name = var.tgw_name
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.tg.id
}
