hcl
// Define the AWS provider
provider "aws" {
  region = var.region
}

// Module to create an AWS Transit Gateway
resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  tags = {
    Name = var.name
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
}
