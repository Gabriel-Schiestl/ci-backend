terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = "1.12.2"
}

provider "aws" {
  region  = "us-east-1"
  profile = "tf01"
}

resource "random_pet" "remote_state" {
  length = 5
}

resource "aws_s3_bucket" "this" {
  bucket = "tf-remote-state-${random_pet.remote_state.id}"

  region = "us-east-1"

  tags = {
    "Owner" : "Gabriel Schiestl"

    "Role" : "Remote state"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enabled
  }
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}