hcl
// Define the Terraform provider for AWS
provider "aws" {
  region = var.region
}

// Transit Gateway resource definition
resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  amazon_side_asn = var.amazon_side_asn

  // Enable DNS support
  dns_support = var.dns_support

  // Allow VPN attachments
  vpn_ecmp_support = var.vpn_ecmp_support

  // Enable default route table propagation
  default_route_table_propagation = var.default_route_table_propagation

  // Enable default route table association
  default_route_table_association = var.default_route_table_association

  // Tags for the Transit Gateway
  tags = {
    Name = var.name
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}
