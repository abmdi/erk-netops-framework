hcl
// Define the AWS provider to interact with AWS resources
provider "aws" {
  region = var.aws_region
}

// Module to create AWS Transit Gateway
module "transit_gateway" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  // Set the name and description for the Transit Gateway
  name        = var.transit_gateway_name
  description = var.transit_gateway_description

  // Define Transit Gateway options
  amazon_side_asn = var.amazon_side_asn

  // Tags to organize resources
  tags = {
    Name        = var.transit_gateway_name
    Environment = var.environment
  }
}

// Outputs for the Transit Gateway ID
output "transit_gateway_id" {
  description = "ID of the created AWS Transit Gateway"
  value       = module.transit_gateway.this_ec2_transit_gateway_id
}
```

// Variables file: variables.tf
```hcl
// Define the required variables with appropriate types and descriptions

variable "aws_region" {
  description = "The AWS region where the resources will be created."
  type        = string
}

variable "transit_gateway_name" {
  description = "The name of the Transit Gateway."
  type        = string
}

variable "transit_gateway_description" {
  description = "A description for the Transit Gateway."
  type        = string
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the Gateway."
  type        = number
  default     = 64512
}

variable "environment" {
  description = "The environment tag for the resources, e.g., dev, prod."
  type        = string
}
```

// CI/CD Pipeline configuration file: .github/workflows/main.yml
```yaml
name: Terraform

on:
  push:
    branches:
      - main

jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v1
      with:
        terraform_version: 1.0.0

    - name: Terraform Init
      run: terraform init

    - name: Terraform Plan
      run: terraform plan

    - name: Terraform Apply
      run: terraform apply -auto-approve
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

This module is designed to set up an AWS Transit Gateway using Terraform and integrate it into a CI/CD pipeline with GitHub Actions, ensuring automated deployment on code push to the main branch.