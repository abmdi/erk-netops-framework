provider "aws" {
  version = "~> 4.0"
  region  = var.region
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  # Enable bucket versioning
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

  # Enable logging
  logging {
    target_bucket = var.logging_bucket
    target_prefix = "${var.bucket_name}/logs/"
  }

  # Define public access block to prevent public access
  block_public_access {
    block_public_acls   = true
    block_public_policy = true
    ignore_public_acls  = true
    restrict_public_buckets = true
  }

  tags = merge(
    {
      "Name"        = var.bucket_name
      "Environment" = var.environment
    },
    var.additional_tags
  )
}

# Output the bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.main.bucket
  description = "The name of the S3 bucket"
}

# Variables required for the module
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "logging_bucket" {
  description = "The S3 bucket to store access logs"
  type        = string
}

variable "environment" {
  description = "The environment for which the bucket is created"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to be added to the bucket"
  type        = map(string)
  default     = {}
}