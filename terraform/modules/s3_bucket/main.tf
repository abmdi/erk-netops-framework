hcl
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Enable server access logging
  logging {
    target_bucket = var.logging_target_bucket
    target_prefix = "${var.bucket_name}/logs/"
  }

  # Configure bucket policy to allow logging
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "logging.s3.amazonaws.com"
        },
        Action = "s3:PutObject",
        Resource = "arn:aws:s3:::${var.logging_target_bucket}/${var.bucket_name}/logs/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:s3:::${aws_s3_bucket.this.bucket}"
          }
        }
      }
    ]
  })

  # Enforce SSL for all communications with the bucket
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Deny",
        Principal = "*",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.this.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.this.bucket}/*"
        ],
        Condition = {
          Bool = {
            "aws:SecureTransport" = false
          }
        }
      }
    ]
  })
}

variable "region" {
  description = "The AWS region to deploy the bucket in."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "logging_target_bucket" {
  description = "The name of the S3 bucket where access logs should be stored."
  type        = string
}

variable "account_id" {
  description = "The AWS account ID for policy conditions."
  type        = string
}
