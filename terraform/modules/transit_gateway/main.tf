hcl
// This Terraform module provisions an AWS Transit Gateway (TGW)

// Defining the provider
provider "aws" {
  region = var.region
}

// Resource block for creating a Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  description = "Example Transit Gateway for network infrastructure"
  
  // Enable default route table propagation
  default_route_table_propagation = var.default_route_table_propagation

  // Enable default route table association
  default_route_table_association = var.default_route_table_association

  // Enable DNS support
  dns_support = var.dns_support

  // Enable VPN ECMP support
  vpn_ecmp_support = var.vpn_ecmp_support

  // Tags to organize resources
  tags = {
    Name = var.tgw_name
  }
}

// Output block to export the Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.example.id
}
```

FILE_PATH: terraform/modules/transit_gateway/variables.tf