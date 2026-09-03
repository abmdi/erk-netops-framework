hcl
// Define a Terraform module to create an AWS Transit Gateway

// Specify the provider
provider "aws" {
  version = "~> 3.0"
  region  = var.aws_region
}

// Create the Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  // Enable default route table association
  default_route_table_association = true
  
  // Enable default route table propagation
  default_route_table_propagation = true
  
  // Set the Amazon Resource Name (ARN) for the transit gateway
  amazon_side_asn = var.amazon_side_asn

  // Describe the purpose of the Transit Gateway
  description = "Example Transit Gateway for cross-VPC communication"
  
  // Tags for resource identification and management
  tags = {
    Name = "example-transit-gateway"
  }
}

// Output the created Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the created Transit Gateway"
  value       = aws_ec2_transit_gateway.example.id
}
```

// This module creates an AWS Transit Gateway with default settings for route table association and propagation. 
// It outputs the Transit Gateway ID for use in other parts of the infrastructure configuration.