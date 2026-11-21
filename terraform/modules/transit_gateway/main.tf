hcl
// Define the AWS provider with required region
provider "aws" {
  region = var.region
}

// Module to create AWS Transit Gateway
resource "aws_ec2_transit_gateway" "example" {
  description = var.description

  // Configure optional settings
  auto_accept_shared_attachments = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support = var.dns_support
  vpn_ecmp_support = var.vpn_ecmp_support
  tags = var.tags
}

// Output the Transit Gateway ID for further use
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.example.id
}
```

```hcl
// Define input variables with default values and descriptions

// AWS region where resources will be created
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

// Description for the Transit Gateway
variable "description" {
  description = "Description of the Transit Gateway"
  type        = string
  default     = "My Transit Gateway"
}

// Auto-accept shared attachments setting
variable "auto_accept_shared_attachments" {
  description = "Auto-accept shared attachments"
  type        = string
  default     = "disable"
}

// Default route table association setting
variable "default_route_table_association" {
  description = "Enable or disable default route table association"
  type        = string
  default     = "enable"
}

// Default route table propagation setting
variable "default_route_table_propagation" {
  description = "Enable or disable default route table propagation"
  type        = string
  default     = "enable"
}

// DNS support setting
variable "dns_support" {
  description = "Enable or disable DNS support"
  type        = string
  default     = "enable"
}

// VPN ECMP support setting
variable "vpn_ecmp_support" {
  description = "Enable or disable VPN ECMP support"
  type        = string
  default     = "disable"
}

// Tags for the Transit Gateway
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {
    Name = "example-transit-gateway"
  }
}
