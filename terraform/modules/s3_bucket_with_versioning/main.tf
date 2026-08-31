provider "aws" {
  # AWS region where resources will be created
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  # Unique bucket name
  bucket = var.bucket_name

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Configure bucket ACL
  acl = "private"

  tags = {
    # Tagging for identification and cost tracking
    Environment = var.environment
    Project     = var.project
  }
}

# Output the bucket ARN for reference
output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

# Define input variables
variable "region" {
  description = "The AWS region where the bucket will be created"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)"
  type        = string
}

variable "project" {
  description = "The project name for tagging"
  type        = string
}