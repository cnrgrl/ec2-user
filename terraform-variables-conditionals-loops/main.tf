terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
  #env variable in my local has already .aws credentials
}

variable "ec2_name" {
  default = "windows"

}

variable "ec2_type" {
  default = "t2.micro"
}

variable "s3_bucket_name" {
  default = "cnr-tf-test-bucket"
}

locals {
  mytag = "from-local"
}

# Create an ec2 instance (aws linux)
resource "aws_instance" "tf-ec2" {
  ami           = "ami-066784287e358dad1"
  instance_type = var.ec2_type
  key_name      = "cnr-key-1"

  tags = {
    Name = "${local.mytag}-${var.ec2_name}"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "${var.s3_bucket_name}-1"
   tags = {
    Name = "${local.mytag}-created"
  }
}

# Outputs
output "tf_example_public_ip" {
  value = aws_instance.tf-ec2.public_ip
}

output "tf_example_s3_meta" {
  value = aws_s3_bucket.example.region
}