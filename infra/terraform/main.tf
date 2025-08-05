terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = "1.12.2"

  backend "s3" {
    bucket = aws_s3_bucket.this.bucket

    key = "terraform.tfstate"

    region = "us-east-1"

    profile = "tf01"
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}