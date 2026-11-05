provider "aws" {
  # Specify the AWS region
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  # Define the S3 bucket name
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

  # Set the ACL policy for public access to private
  acl = "private"

  # Add a tag to the bucket for identification
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment in which this resource is deployed."
  type        = string
  default     = "dev"
}