provider "aws" {
  region = var.region
}

resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  amazon_side_asn = var.amazon_side_asn

  # Enable default route table association
  default_route_table_association = var.default_route_table_association

  # Enable default route table propagation
  default_route_table_propagation = var.default_route_table_propagation

  tags = {
    Name = var.name
  }
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_id

  tags = {
    Name = "${var.name}-vpc-attachment"
  }
}

# Outputs for terraform module
output "transit_gateway_id" {
  description = "The ID of the Transit Gateway."
  value       = aws_ec2_transit_gateway.this.id
}

output "transit_gateway_route_table_id" {
  description = "The ID of the Transit Gateway Route Table."
  value       = aws_ec2_transit_gateway_route_table.this.id
}