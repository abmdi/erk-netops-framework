hcl
// Define the AWS provider to use
provider "aws" {
  region = var.region
}

// Create an S3 bucket with server-side encryption enabled
resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.bucket_name

  // Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  // Enable versioning to keep track of object versions
  versioning {
    enabled = true
  }

  // Enable access logging for the bucket
  logging {
    target_bucket = var.logging_bucket
    target_prefix = "${var.bucket_name}/logs/"
  }

  // Enable lifecycle policies to transition and expire objects
  lifecycle_rule {
    id      = "transition_and_expiration"
    enabled = true

    // Transition objects to STANDARD_IA after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    // Expire objects after 365 days
    expiration {
      days = 365
    }
  }
}

// Outputs
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.secure_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.secure_bucket.arn
}
