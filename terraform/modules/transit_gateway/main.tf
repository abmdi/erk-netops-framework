hcl
// Define a module for creating AWS Transit Gateway
resource "aws_ec2_transit_gateway" "this" {
  description = var.description // Description for the Transit Gateway

  // Define the default route table association
  default_route_table_association = var.default_route_table_association

  // Define the default route table propagation
  default_route_table_propagation = var.default_route_table_propagation

  tags = var.tags // Tags to organize the resource
}

// Output the ID of the created Transit Gateway
output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
}
```

COMMIT_MSG: Add variables and outputs for Transit Gateway module
FILE_PATH: terraform/modules/transit_gateway/variables.tf