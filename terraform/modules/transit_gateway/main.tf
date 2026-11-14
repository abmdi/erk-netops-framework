hcl
# Terraform module for deploying an AWS Transit Gateway

# Define variables for the Transit Gateway
variable "transit_gateway_name" {
  description = "Name of the transit gateway"
  type        = string
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway"
  type        = number
  default     = 64512
}

# Create the Transit Gateway
resource "aws_ec2_transit_gateway" "this" {
  description        = var.transit_gateway_name
  amazon_side_asn    = var.amazon_side_asn
  tags = {
    Name = var.transit_gateway_name
  }
}

# Output the ID of the Transit Gateway
output "transit_gateway_id" {
  description = "The ID of the created Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}
