hcl
// Define a module for creating an AWS Transit Gateway
variable "tgw_name" {
  description = "Name of the Transit Gateway"
  type        = string
}

variable "region" {
  description = "AWS region where the Transit Gateway should be created"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_ec2_transit_gateway" "this" {
  description = var.tgw_name

  // Enable default route table association and propagation
  default_route_table_association = true
  default_route_table_propagation = true

  // Enable DNS support and VPN ECMP support
  dns_support        = "enable"
  vpn_ecmp_support   = "enable"
  auto_accept_shared_attachments = "disable" // Disable auto-accept of shared attachments for security
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  description = "ID of the created Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}
