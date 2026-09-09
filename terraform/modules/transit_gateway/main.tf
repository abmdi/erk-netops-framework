hcl
// Define the AWS provider
provider "aws" {
  region = var.region
}

// Create a Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  description = "Transit Gateway for connecting VPCs"
  tags = {
    Name = var.transit_gateway_name
  }
}

// Define outputs for the Transit Gateway ID
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.example.id
}
```

COMMIT_MSG: Add variables and outputs for Transit Gateway module
FILE_PATH: terraform/modules/transit_gateway/variables.tf