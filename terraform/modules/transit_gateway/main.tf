hcl
// Define the Terraform provider for AWS
provider "aws" {
  region = var.region
}

// Module for creating an AWS Transit Gateway
module "transit_gateway" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  // Basic Transit Gateway configuration
  name        = var.transit_gateway_name
  description = var.transit_gateway_description

  // Options for the Transit Gateway
  amazon_side_asn       = var.amazon_side_asn
  auto_accept_shared_attachments = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation

  // Tagging for the Transit Gateway resources
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  description = "ID of the AWS Transit Gateway"
  value       = module.transit_gateway.this_ec2_transit_gateway_id
}
