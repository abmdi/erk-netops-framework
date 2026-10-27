provider "aws" {
  # Configure the AWS provider with default settings
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  # Enable versioning for the S3 bucket
  versioning {
    enabled = true
  }

  # Apply server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Configure public access block to ensure bucket is not publicly accessible
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true

  # Enable logging for the bucket
  logging {
    target_bucket = var.logging_bucket
    target_prefix = "${var.bucket_name}/logs/"
  }

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# Define input variables for the module
variable "aws_region" {
  description = "The AWS region where the S3 bucket will be created."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "logging_bucket" {
  description = "The bucket where access logs will be stored."
  type        = string
}

variable "environment" {
  description = "The environment in which this bucket is used (e.g., dev, prod)."
  type        = string
}