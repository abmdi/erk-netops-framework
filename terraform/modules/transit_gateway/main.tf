hcl
// Define the AWS provider
provider "aws" {
  region = var.region
}

// Module to create a Transit Gateway
resource "aws_ec2_transit_gateway" "main" {
  description = var.transit_gateway_description
  tags = {
    Name = var.transit_gateway_name
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.main.id
}
```

COMMIT_MSG: Add variables and outputs for Transit Gateway module
FILE_PATH: terraform/modules/transit_gateway/variables.tf