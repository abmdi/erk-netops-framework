hcl
// Define a Terraform module for creating an AWS S3 bucket
module "s3_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = var.bucket_name
  tags        = var.tags
}

// Declare a variable for the bucket name
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

// Declare a variable for tags
variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

// Create an S3 bucket resource
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  // Enable bucket versioning
  versioning {
    enabled = true
  }

  // Enable server-side encryption using the AES256 algorithm
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  // Add tags to the bucket
  tags = var.tags
}

// Output the bucket name
output "bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.this.bucket
}
