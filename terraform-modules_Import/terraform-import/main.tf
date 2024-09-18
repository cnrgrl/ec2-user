import {
  to = aws_instance.example
  id = "i-099cf28d20079515f"
}

resource "aws_instance" "example" {
  ami = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"
  # (resource arguments...)
}
