hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

resource "aws_ec2_transit_gateway" "this" {
  description = var.description

  // Enable default route table association
  default_route_table_association = var.default_route_table_association

  // Enable default route table propagation
  default_route_table_propagation = var.default_route_table_propagation

  // Enable DNS support
  dns_support = var.dns_support

  // Enable VPN ECMP support
  vpn_ecmp_support = var.vpn_ecmp_support

  // Enable multi-region support
  amazon_side_asn = var.amazon_side_asn
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
  description = "The ID of the Transit Gateway"
}
```

```hcl
variable "region" {
  description = "The AWS region to deploy the Transit Gateway"
  type        = string
}

variable "description" {
  description = "A description for the Transit Gateway"
  type        = string
  default     = "My Transit Gateway"
}

variable "default_route_table_association" {
  description = "Enable or disable automatic association with the default route table"
  type        = string
  default     = "enable"
}

variable "default_route_table_propagation" {
  description = "Enable or disable automatic propagation to the default route table"
  type        = string
  default     = "enable"
}

variable "dns_support" {
  description = "Enable or disable DNS support"
  type        = string
  default     = "enable"
}

variable "vpn_ecmp_support" {
  description = "Enable or disable VPN Equal Cost Multi-Path (ECMP) support"
  type        = string
  default     = "enable"
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side"
  type        = number
  default     = 64512
}
