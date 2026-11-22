hcl
// Define the main module for creating an S3 bucket with versioning and encryption

// Define the provider
provider "aws" {
  region = var.region
}

// Define the S3 bucket resource
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  // Enable bucket versioning
  versioning {
    enabled = var.enable_versioning
  }

  // Enable default server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  // Set bucket ACL to private
  acl = "private"

  // Tags for the bucket
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

// Define the output for the S3 bucket name
output "bucket_name" {
  value = aws_s3_bucket.this.id
  description = "The name of the S3 bucket"
}
