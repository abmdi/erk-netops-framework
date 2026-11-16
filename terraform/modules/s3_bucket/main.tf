hcl
provider "aws" {
  version = "~> 3.0"
  region  = var.region
}

module "s3_bucket" {
  source = "./s3_bucket"

  bucket_name = var.bucket_name
  log_bucket  = var.log_bucket
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # Enable versioning to keep track of changes to files
  versioning {
    enabled = true
  }

  # Enable logging for the bucket to another S3 bucket
  logging {
    target_bucket = var.log_bucket
    target_prefix = "${var.bucket_name}/"
  }

  # Ensure the bucket ACL is set to private
  acl = "private"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "log_bucket" {
  description = "The name of the S3 bucket to store logs"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}
