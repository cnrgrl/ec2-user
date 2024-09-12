provider "aws" {
    region = "us-east-1"
  }

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version ="5.30.0"
    }
  }
}

variable "num_of_buckets" {
    default = 2
}

variable "s3_bucket_name" {
  default = "counted-buckets-cnr"
}

variable "users" {
  default = ["john", "mohn", "tohn"]
}

resource "aws_s3_bucket" "tf-s3-cnr" {
#   bucket = "${var.s3_bucket_name}-${count.index}"
#   count = var.num_of_buckets
#   count = var.num_of_buckets != 0 ? var.num_of_buckets : 3
  for_each = toset(var.users)
  bucket = "example-tf-s3-bucket-${each.value}"
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}