terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.49.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tf-instances" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = "cnr-key-1"
  tags = {
    Name = "ubuntu-24.04"
  }
}
