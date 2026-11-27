hcl
// Terraform module for AWS Transit Gateway

// Define the AWS provider
provider "aws" {
  region = var.region
}

// Create a Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  description = var.transit_gateway_description
  tags = var.tags
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.example.id
}

// Variables for the module
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "transit_gateway_description" {
  description = "Description for the AWS Transit Gateway"
  type        = string
  default     = "Example Transit Gateway"
}

variable "tags" {
  description = "A map of tags to assign to the Transit Gateway"
  type        = map(string)
  default     = {}
}
