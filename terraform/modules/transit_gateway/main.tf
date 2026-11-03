provider "aws" {
  region = var.region
}

resource "aws_ec2_transit_gateway" "tgw" {
  description = var.tgw_description

  // Enable DNS support for the Transit Gateway
  dns_support = "enable"

  // Enable VPN ECMP support for more efficient routing
  vpn_ecmp_support = "enable"

  // Default route table association setting
  default_route_table_association = "enable"

  // Default route table propagation setting
  default_route_table_propagation = "enable"

  // Amazon side ASN for the Transit Gateway
  amazon_side_asn = var.amazon_side_asn

  tags = {
    Name = var.tgw_name
  }
}

resource "aws_ec2_transit_gateway_route_table" "tgw_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "${var.tgw_name}-route-table"
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the created Transit Gateway"
  value       = aws_ec2_transit_gateway.tgw.id
}