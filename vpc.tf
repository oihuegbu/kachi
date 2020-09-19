resource "aws_vpc" "kashvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "kashvpc"
  }
}