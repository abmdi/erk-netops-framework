provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  # Enable default server-side encryption using AES-256
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

  # Enable versioning to keep multiple variants of an object in the same bucket
  versioning {
    enabled = true
  }

  # Configure lifecycle rules to transition objects to STANDARD_IA class after 30 days
  lifecycle_rule {
    enabled = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # Expire objects after 365 days
    expiration {
      days = 365
    }
  }

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for resource tagging"
  type        = string
  default     = "production"
}