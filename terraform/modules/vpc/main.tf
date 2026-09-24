hcl
// Define the Terraform provider to use AWS
provider "aws" {
  region = var.region // Use variable to specify the AWS region
}

// Define a Terraform module for creating a VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws" // Utilize community-maintained module for VPC

  name = var.vpc_name // Name of the VPC from variables
  cidr = var.vpc_cidr // CIDR block for the VPC from variables

  azs             = var.availability_zones // List of availability zones
  private_subnets = var.private_subnets    // CIDR blocks for private subnets
  public_subnets  = var.public_subnets     // CIDR blocks for public subnets

  enable_nat_gateway = true // Enable NAT Gateway for outbound internet access

  tags = {
    Environment = var.environment // Environment tag for resource identification
  }
}

// Output the ID of the newly created VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
