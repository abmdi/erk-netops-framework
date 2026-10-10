hcl
// Define the AWS provider
provider "aws" {
  region = var.aws_region
}

// Define the Transit Gateway module
module "transit_gateway" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 3.0"

  // Specify the Transit Gateway parameters
  name        = var.transit_gateway_name
  description = var.transit_gateway_description

  // Enable default route table association
  default_route_table_association = true

  // Enable default route table propagation
  default_route_table_propagation = true

  // Set up tags for the Transit Gateway
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

// Define output variables for further use
output "transit_gateway_id" {
  description = "ID of the created Transit Gateway"
  value       = module.transit_gateway.this_ec2_transit_gateway_id
}

output "transit_gateway_arn" {
  description = "ARN of the created Transit Gateway"
  value       = module.transit_gateway.this_ec2_transit_gateway_arn
}
