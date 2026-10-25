hcl
# Define a Terraform module to create an AWS Transit Gateway

# Specify the required provider
provider "aws" {
  version = "~> 4.0"
  region  = var.region  # Use the region specified in variables
}

# Define the Transit Gateway resource
resource "aws_ec2_transit_gateway" "tgw" {
  # Name of the Transit Gateway for easy identification
  description = var.description

  # Options for the Transit Gateway
  options {
    amazon_side_asn = var.amazon_side_asn  # ASN for the Amazon side
  }

  # Tags to identify the resource
  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

# Outputs to be used by other modules or resources
output "transit_gateway_id" {
  value       = aws_ec2_transit_gateway.tgw.id
  description = "The ID of the Transit Gateway"
}

output "transit_gateway_arn" {
  value       = aws_ec2_transit_gateway.tgw.arn
  description = "The ARN of the Transit Gateway"
}
