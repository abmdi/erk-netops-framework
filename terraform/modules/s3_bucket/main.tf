provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  # Enable versioning to preserve, retrieve, and restore versions of objects
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

  # Enable public access block configuration to prevent public access
  block_public_access {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

# Output bucket ARN for reference
output "bucket_arn" {
  value = aws_s3_bucket.example.arn
}

# Variables required for the module
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}