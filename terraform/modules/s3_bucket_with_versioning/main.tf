hcl
// Define a module to create an S3 bucket with versioning enabled

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "The AWS region where the S3 bucket will be created"
  type        = string
  default     = "us-west-2"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {
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

  // Enable access logging
  logging {
    target_bucket = "your-logging-bucket-name"
    target_prefix = "log/"
  }

  // Tags for the bucket
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket
}
