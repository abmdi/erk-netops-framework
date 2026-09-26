hcl
// Define a module to create an AWS S3 bucket with versioning enabled

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "The AWS region where the S3 bucket will be created"
  type        = string
  default     = "us-west-2" // Default region set to us-west-2
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  // Enable versioning to keep multiple versions of objects in the bucket
  versioning {
    enabled = true
  }

  // Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256" // Use AES-256 encryption
      }
    }
  }

  // Define a lifecycle rule to automatically delete incomplete multipart uploads after 7 days
  lifecycle_rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  tags = {
    Name        = var.bucket_name
    Environment = "production"
  }
}
