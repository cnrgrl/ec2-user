terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
  ## profile = "my-profile"
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-01b799c439fd5516a"
  instance_type = "t2.micro"
  tags = {
    "Name" = "created-by-tf"
  }
}