provider "aws" {
  # Specify the AWS region
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  # Name of the S3 bucket
  bucket = var.bucket_name

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Define server-side encryption configuration
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Block public access to the bucket
  block_public_access {
    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = true
    restrict_public_buckets = true
  }

  tags = {
    # Tagging for resource identification and cost management
    Name        = var.bucket_name
    Environment = var.environment
  }
}

variable "region" {
  # Define the AWS region for the S3 bucket
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "bucket_name" {
  # Define the S3 bucket name
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  # Define the deployment environment (e.g., dev, prod)
  description = "The environment for resource deployment"
  type        = string
}