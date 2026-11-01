hcl
// Define a module for creating an AWS VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  // Basic VPC configurations
  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_dns_support   = true
  enable_dns_hostnames = true

  // NAT gateway configuration
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "Name" = var.vpc_name
    "Env"  = var.environment
  }
}

// Data source to fetch AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
