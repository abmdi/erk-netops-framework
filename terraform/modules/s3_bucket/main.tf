provider "aws" {
  # AWS region where resources will be created
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  # Name of the S3 bucket
  bucket = var.bucket_name

  # Enable versioning for the S3 bucket
  versioning {
    enabled = true
  }

  # Enforce server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enforce bucket-level public access blocking
  block_public_access {
    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = true
    restrict_public_buckets = true
  }

  tags = {
    # Tags for identifying and organizing resources
    Environment = var.environment
    Project     = var.project
  }
}

variable "aws_region" {
  # AWS region variable
  description = "The AWS region to create resources in."
  type        = string
}

variable "bucket_name" {
  # S3 bucket name variable
  description = "The name of the S3 bucket."
  type        = string
}

variable "environment" {
  # Environment tag variable
  description = "The environment for the S3 bucket (e.g., dev, prod)."
  type        = string
}

variable "project" {
  # Project tag variable
  description = "The project name to tag the S3 bucket with."
  type        = string
}