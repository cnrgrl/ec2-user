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

# Create an ec2 instance (aws linux)
resource "aws_instance" "tf-ec2" {
#   ami           = data.aws_ami.ubuntu.id
  ami           = "ami-066784287e358dad1"
  instance_type = "t2.micro"
  key_name = "cnr-key-1"

  tags = {
    Name = "from-local-windows"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "cnr-tf-test-bucket-1"
}