provider "aws" {
  # Configure the AWS provider with the region
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  # Define the S3 bucket name
  bucket = var.bucket_name

  # Enable bucket versioning for data protection
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
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
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  # Tag the bucket for identification and management
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# Define input variables
variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for the bucket (e.g., dev, prod)"
  type        = string
}