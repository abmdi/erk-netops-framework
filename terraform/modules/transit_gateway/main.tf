hcl
// Define the Terraform AWS provider
provider "aws" {
  version = "~> 3.0"
  region  = var.region
}

// Module to create an AWS Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  description = "Example Transit Gateway"
  # Setting the default route table association to automatic
  default_route_table_association = "enable"
  # Setting the default route table propagation to automatic
  default_route_table_propagation = "enable"
  # Enable DNS support between VPCs
  dns_support = "enable"
  # Enable VPN ECMP support
  vpn_ecmp_support = "enable"
  // Enable multicast support
  multicast_support = "enable"

  // Tags to help identify this resource
  tags = {
    Name = var.transit_gateway_name
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.example.id
}
