resource "aws_subnet" "subl" {
  vpc_id     = aws_vpc.Randa.id
  cidr_block = var.sub1_cidr

  tags = {
    Name = "var.sub1_tag"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.Randa.id
  cidr_block = var.sub2_cidr

  tags = {
    Name = "var.sub2_tag"
  }
}


