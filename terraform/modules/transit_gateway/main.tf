hcl
// This Terraform module creates an AWS Transit Gateway
provider "aws" {
  region = var.region
}

resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  amazon_side_asn = var.amazon_side_asn

  // Optional parameters
  auto_accept_shared_attachments = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support = var.dns_support
  vpn_ecmp_support = var.vpn_ecmp_support

  tags = merge({
    Name = var.name
  }, var.tags)
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = merge({
    Name = "${var.name}-route-table"
  }, var.tags)
}

// Outputs for the created resources
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}

output "transit_gateway_route_table_id" {
  description = "The ID of the Transit Gateway Route Table"
  value       = aws_ec2_transit_gateway_route_table.this.id
}

// Variables with default values and descriptions
variable "region" {
  description = "AWS region in which to create the Transit Gateway"
  type        = string
}

variable "name" {
  description = "Name for the Transit Gateway"
  type        = string
}

variable "description" {
  description = "Description for the Transit Gateway"
  type        = string
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway"
  type        = number
}

variable "auto_accept_shared_attachments" {
  description = "Whether to automatically accept cross-account attachments"
  type        = string
  default     = "disable"
}

variable "default_route_table_association" {
  description = "Whether resource attachments are automatically associated with the default association route table"
  type        = string
  default     = "enable"
}

variable "default_route_table_propagation" {
  description = "Whether resource attachments are automatically propagated to the default propagation route table"
  type        = string
  default     = "enable"
}

variable "dns_support" {
  description = "Whether DNS support is enabled"
  type        = string
  default     = "enable"
}

variable "vpn_ecmp_support" {
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
  type        = string
  default     = "enable"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
