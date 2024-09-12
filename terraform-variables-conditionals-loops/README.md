# VARIABLES, CONDITIONS, LOOPS

### Part -1: Terraform Commands

`validate` command controls the code syntax and shows the eventual errors.

```bash
terraform validate
```

`fmt` command formats the code blocks and prettifies indentations.

```bash
terraform fmt
```

`console` command provides an interactive command-line console for evaluating and experimenting with expressions. This is useful for testing interpolations before using them in configurations, and for interacting with any values currently saved in state. You can see the attributes of resources in tfstate file and check built in functions before you write in your configuration file.

```bash
terraform console
> aws_instance.tf-ec2.private_ip
> min (1,2,3)
> lower("HELLO")
> file("${path.module}/cloud")
> aws_s3_bucket.tf-s3.bucket
> exit or (ctrl+c)
```

 `show` command provide tfstate file or plan in the terminal. It is more readable than `terraform.tfstate`.

```bash
terraform show
```

`graph` command creates a visual graph of Terraform resources. The output of "terraform graph" command is in the DOT format, which can easily be converted to an image by making use of dot provided by **GraphViz.**

- *Copy the output and paste it to the [`https://dreampuf.github.io/GraphvizOnline`](https://dreampuf.github.io/GraphvizOnline). Then display it. If you want to display this output in your local, you can download graphviz (`sudo yum install graphviz`) and take a `graph.svg` with the command `terraform graph | dot -Tsvg > graph.svg`.*

```bash
terraform graph
```

`output` command provides us values that make information about our infrastructure available on the command line, and can expose information for other Terraform configurations to use.

Let's try this block in `main.tf`
```
output "s3_region" {
  value = aws_s3_bucket.tf-s3.region
}
```

```bash
terraform output
terraform output -json
terraform output tf_example_public_ip
```
___

### Part - 2 : Variables

The methods in precedence order:

1. **command line option with `-var` flag**

```bash
terraform plan -var="s3_bucket_name=s3-bucket-variable-from-command-line"
```

2. **environment variable with `TF_VAR_` prefix**

```bash
export TF_VAR_s3_bucket_name=s3_bucket_name=s3-bucket-variable-from-environment-variable
terraform plan
```

3. **variables with `terraform.tfvars` file**

```go
s3_bucket_name = "tfvars-bucket"
```

4. **variables with user-defined `myvars.tfvars` files(including `myvars.auto.tfvars`) loaded next**

```go
s3_bucket_name = "tfvars-bucket"
```

5. **variables with `terraform.tfvars` file**

```go
s3_bucket_name = "tfvars-bucket"
```

6. **In root module** `main.tf` : If none of the above sources provide a value, the variable will fall back to any default value specified in the variable block within your Terraform configuration.

```bash

variable "s3_bucket_name" {
  default = "s3-bucket-variable-from-root-module"
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = var.s3_bucket_name
}
```

7. **Local Values**: Local values defined within `main.tf` using the locals block also have a lower precedence than the methods listed above.

```bash
locals {
  mytag = "from-local"
}

resource "aws_s3_bucket" "example" {
  bucket = "${var.s3_bucket_name}-1"
  tags = {
    Name = "${local.mytag}-created"
  }
}
```

___ 

### Part 3: Conditionals and Loops

By default, a resource block configures one real infrastructure object. However, sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one. Terraform has two ways to do this: **count** and **for_each**.

`count`

```go
variable "num_of_buckets" {
  default = 2
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "myBucket-${count.index}"
  count = var.num_of_buckets
}
```

`for_each`


```go
variable "users" {
  default = ["santino", "michael", "fredo"]
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}
```

A **conditional expression** uses the value of a boolean expression to select one of two values.

```go
variable "num_of_buckets" {
  default = 2
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "myBucket-${count.index}"
  count = var.num_of_buckets != 0 ? var.num_of_buckets : 3
}
```