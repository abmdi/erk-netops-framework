hcl
// Define the provider to use
provider "aws" {
  region = var.aws_region
}

// Create an S3 bucket with versioning and encryption
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  // Enable versioning for the bucket
  versioning {
    enabled = true
  }

  // Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  // Set the ACL to private to restrict access
  acl = "private"
}

// Output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
