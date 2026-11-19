hcl
// Define the Terraform provider for AWS
provider "aws" {
  region = var.region
}

// Define a module to create an AWS Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  description = var.tgw_description
  amazon_side_asn = var.amazon_side_asn

  // Tags for organizing resources
  tags = {
    Name        = var.tgw_name
    Environment = var.environment
  }
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  description = "ID of the created Transit Gateway"
  value       = aws_ec2_transit_gateway.example.id
}
```

FILE_PATH: terraform/modules/transit_gateway/variables.tf