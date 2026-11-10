hcl
// Define a Terraform module for creating an AWS Transit Gateway

provider "aws" {
  // Specify the AWS region
  region = var.region
}

resource "aws_ec2_transit_gateway" "example" {
  // Set description for the Transit Gateway
  description = var.description

  // Specify whether default route table association is enabled
  default_route_table_association = var.default_route_table_association

  // Specify whether default route table propagation is enabled
  default_route_table_propagation = var.default_route_table_propagation

  // Specify whether VPN ECMP support is enabled
  vpn_ecmp_support = var.vpn_ecmp_support

  // Specify the Amazon side ASN
  amazon_side_asn = var.amazon_side_asn

  // Specify whether DNS support is enabled
  dns_support = var.dns_support

  // Specify whether multicast support is enabled
  multicast_support = var.multicast_support

  // Tags associated with the Transit Gateway
  tags = var.tags
}

output "transit_gateway_id" {
  // Output the Transit Gateway ID
  value = aws_ec2_transit_gateway.example.id
}
```

FILE_PATH: terraform/modules/transit_gateway/variables.tf