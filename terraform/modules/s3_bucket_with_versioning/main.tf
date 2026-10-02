hcl
// Define the AWS provider
provider "aws" {
  region = var.region
}

// Create an S3 bucket with versioning enabled
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  // Enable versioning for the bucket
  versioning {
    enabled = true
  }

  // Define tags for the S3 bucket
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

// Define input variables
variable "region" {
  description = "The AWS region to deploy the resources."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
}

output "bucket_name" {
  description = "The name of the created S3 bucket."
  value       = aws_s3_bucket.my_bucket.bucket
}
