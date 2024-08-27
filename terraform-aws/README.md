# Terraform Installation and Basic Operations

- ### This ```main.tf``` file creates a **AWS EC2 instance** and **AWS S3 bucket** .

___

## *Follow the steps:*

Once an amazon linux instance launched,

1. Install yum-config-manager to manage your repositories.

```bash
sudo dnf install -y yum-utils
```

2. Use yum-config-manager to add the official HashiCorp Linux repository.

```bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```
3. Install Terraform from the new repository.

```bash
sudo dnf -y install terraform
```
4. Create a roles `AmazonEC2FullAccess` and `S3FullAccess` for EC2 on which you work and  in IAM management console

5. Create `main.tf` file and configure it.

```t
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
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-01b799c439fd5516a" # find this in AWS EC2 service or google it:  ex:"free tier aws ami id"
  instance_type = "t2.micro"
  key_name      = "cnr_key"    # write your pem file without .pem extension
  tags = {
    "Name" = "tf-ec2"
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "cnr-tf-test-bucket-addwhateveryouwant"
}
```

6. Initialize terraform in the directory of `main.tf`. After that ``.terraform`` will be automatically created.

```bash
terraform init
```

7. First see the the plan what to be created.

```bash
terraform plan
```

8. Finally you can apply the infrastructure. And then see the the resources ec2 instance and S3 bucket in AWS Console.

```bash
terraform apply
```

9. In the directory the tfstate files have been automatically created. Analyze and see in there the resources created.

`terraform.tfstate` , `terraform.tfstate.backup`

10. Optionally the execution plan can be saved in a  binary file. 'justs3' is a custom name you gave. 

```bash
terraform plan -out=justs3
```

11. Later it can be executed as `main.tf` file

```bash
terraform apply justs3
```

12. Now all resources created by `main.tf` can be destroyed easyly.

```bash
terraform destroy
```

___
*By cnrgrl*