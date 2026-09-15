hcl
// Define a module for AWS Transit Gateway

provider "aws" {
  version = "~> 4.0"
}

// Module for AWS Transit Gateway
resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  tags = var.tags
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}

variable "description" {
  description = "Description for the Transit Gateway"
  type        = string
  default     = "Main Transit Gateway"
}

variable "tags" {
  description = "Tags to apply to the Transit Gateway"
  type        = map(string)
  default     = {
    Name = "MainTransitGateway"
  }
}
```

This Terraform module creates an AWS Transit Gateway with a default description and tags. It outputs the ID of the created Transit Gateway for use in other modules or resources.