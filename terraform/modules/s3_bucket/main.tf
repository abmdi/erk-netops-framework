provider "aws" {
  # AWS region where the resources will be created
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  # S3 bucket name
  bucket = var.bucket_name

  # Enable versioning to keep multiple versions of an object in the same bucket
  versioning {
    enabled = true
  }

  # Define lifecycle rules for the bucket
  lifecycle_rule {
    id      = "log"
    enabled = true

    # Transition objects to Glacier after 30 days
    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    # Expire objects after 365 days
    expiration {
      days = 365
    }
  }

  tags = {
    # Tag for identifying the purpose of the bucket
    Name        = var.bucket_name
    Environment = var.environment
  }
}

variable "aws_region" {
  # AWS region variable
  description = "The AWS region to create resources in"
  type        = string
}

variable "bucket_name" {
  # Bucket name variable
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  # Environment tag for the bucket
  description = "The environment in which this bucket is used"
  type        = string
  default     = "dev"
}