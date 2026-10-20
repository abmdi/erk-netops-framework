hcl
// Define a module for AWS Transit Gateway
module "transit_gateway" {
  source = "terraform-aws-modules/transit-gateway/aws"

  // Define the name of the Transit Gateway
  name = "erk-netops-transit-gateway"

  // Define the Amazon Resource Name (ARN) of the Transit Gateway
  arn = "arn:aws:ec2:${var.region}:${data.aws_caller_identity.current.account_id}:transit-gateway/${aws_ec2_transit_gateway.this.id}"

  // Define the description of the Transit Gateway
  description = "Transit Gateway for ERK Network Operations"

  // Define the Amazon Resource Name (ARN) of the default route table
  default_route_table_association = true

  // Enable default route table propagation
  default_route_table_propagation = true

  // Define whether the Transit Gateway is shared with other accounts
  share_with_other_accounts = false

  // Define the tags for the Transit Gateway
  tags = {
    Environment = var.environment
    Project     = "erk-netops"
  }
}

// Output the Transit Gateway ID
output "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this.id
}
