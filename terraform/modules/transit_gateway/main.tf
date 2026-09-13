hcl
// Define a Terraform module to create an AWS Transit Gateway

provider "aws" {
  region = "us-east-1" // Specify the AWS region
}

resource "aws_ec2_transit_gateway" "this" {
  description = "Main Transit Gateway for centralized network management" // Description for the Transit Gateway
  
  // Set the default route table association and propagation
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  // Specify tags for identifying and managing the resource
  tags = {
    Name = "Main-Transit-Gateway"
    Environment = "Production"
  }
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  description = "ID of the created Transit Gateway" // Describe the output variable
  value       = aws_ec2_transit_gateway.this.id
}
