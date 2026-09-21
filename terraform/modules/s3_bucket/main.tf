hcl
// Define a Terraform module to create an S3 bucket with versioning and encryption

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  // Enable versioning on the S3 bucket
  versioning {
    enabled = true
  }

  // Enable default encryption for the S3 bucket
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  // Define a default ACL for the S3 bucket
  acl = "private"

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

output "s3_bucket_id" {
  description = "The ID of the created S3 bucket"
  value       = aws_s3_bucket.this.id
}
