hcl
// Define the Terraform provider for AWS
provider "aws" {
  region = var.region
}

// Define a module for creating a VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"

  // VPC basic configuration
  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  
  // Configure subnets for public and private access
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets

  // Enable DNS support and hostnames
  enable_dns_support   = true
  enable_dns_hostnames = true

  // Add tags for the VPC and its resources
  tags = {
    "Environment" = var.environment
    "Owner"       = var.owner
  }
}

// Data source to fetch availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
```

Ensure you define the necessary variables (e.g., `region`, `vpc_name`, `vpc_cidr`, `az_count`, `public_subnets`, `private_subnets`, `environment`, `owner`) in a separate variables file or in the Terraform configuration where you call this module.