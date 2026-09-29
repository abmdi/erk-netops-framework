provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  
  # Enable versioning for the bucket
  versioning {
    enabled = true
  }
  
  # Enable server access logging
  logging {
    target_bucket = var.logging_target_bucket
    target_prefix = "log/"
  }
  
  # Enforce encryption of data at rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# Output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

# Variables for the module
variable "region" {
  description = "The AWS region to create the bucket in"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "logging_target_bucket" {
  description = "The target bucket for server access logs"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}