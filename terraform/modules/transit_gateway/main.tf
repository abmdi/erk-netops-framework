hcl
// Define a Terraform module to create an AWS Transit Gateway
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

// Resource block to create a Transit Gateway
resource "aws_ec2_transit_gateway" "this" {
  // Description of the Transit Gateway
  description = var.tgw_description

  // Amazon-side ASN
  amazon_side_asn = var.amazon_side_asn

  // Tags for the Transit Gateway
  tags = {
    Name = var.tgw_name
  }
}

// Output block to export Transit Gateway details
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}
```

COMMIT_MSG: Add variables and CI/CD pipeline configuration for Transit Gateway module
FILE_PATH: terraform/modules/transit_gateway/variables.tf