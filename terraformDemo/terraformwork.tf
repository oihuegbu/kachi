/* This folder works in conjuction with variables.tf, variables.tfvars
output.tf and vpc.tf */

# provider info. Region set in variables.tf folder
provider "aws" {
  region = var.kashregion
}


#Using data source to provision VPC
data "aws_vpc" "kashvpc"{
  default = true
}

#Using resource block to create an internet gateway. VPC id referenced VPC that IGW will be created in
resource "aws_internet_gateway" "kashGW" {
  vpc_id = aws_vpc.kashvpc.id

  tags = {
    Name = "kashGW"
  }
}


/* Resource block for creating NAT gateway that will be in public subnet, but will allow traffic specific 
out of EC2 instance in private subnet to internet, but will not allow traffic into private subnet */
resource "aws_nat_gateway" "kashNAT" {
 allocation_id = aws_eip.kasheip.id
  subnet_id     = aws_subnet.kashpublic.id

  tags = {
    Name = "gw NAT"
  }
}

/* Resource block for creating elastic IP connected to NAT gateway */
resource "aws_eip" "kasheip" {
  vpc = true

  tags = {
    Name = "kash Elastic IP"
  }
}


/* Resource block for creating route table 1 connecting public subnet to IGW */
resource "aws_route_table" "kashRoute" {
  vpc_id = aws_vpc.kashvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kashGW.id
  }

  tags = {
    Name = "kashPublicRoute"
  }
}

/* Resource block for creating route table 2 connecting to NAT gateway */
resource "aws_route_table" "kashRoute2" {
  
  vpc_id = aws_vpc.kashvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.kashNAT.id
  }

  tags = {
    Name = "kashPrivateRoute"
  }
}

/* Resource block for creating route table associations for public and private subnet */
resource "aws_route_table_association" "kashAssociationPublic" {
  subnet_id = aws_subnet.kashpublic.id
  route_table_id = aws_route_table.kashRoute.id


}

resource "aws_route_table_association" "kashAssociationPrivate" {
  subnet_id = aws_subnet.kashprivate.id
  route_table_id = aws_route_table.kashRoute2.id

}

/* Resource block for creating public subnet with public ip enabled upon launch set to default 
and cidar block configured */
resource "aws_subnet" "kashpublic" {
  vpc_id     = aws_vpc.kashvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "kashPublicsubnet"
  }
}

/* Resource block for creating private subnet with cidar block configured */
resource "aws_subnet" "kashprivate" {
  vpc_id     = aws_vpc.kashvpc.id
  cidr_block = "10.0.2.0/24"
  


  tags = {
    Name = "kashPrivatesubnet"
  }
}

/* Resource block for creating security group allowing only SSH and HTTPS 
traffic in and out, also using TCP protocol */
resource "aws_security_group" "kashSG" {
  name        = "allow_traffic"
  description = "Allow traffic"
  vpc_id      = aws_vpc.kashvpc.id

  ingress {
    description = "inbound traffic from SSH"
    from_port   = var.ssh_traffic
    to_port     = var.ssh_traffic
    protocol    = var.protocol
  }

  ingress {
    description = "inbound traffic from internet"
    from_port   = var.https_traffic
    to_port     = var.https_traffic
    protocol    = var.protocol
  }

  egress {
    description = "outbound traffic to SSH"
    from_port   = var.ssh_traffic
    to_port     = var.ssh_traffic
    protocol    = var.protocol
  }

  egress {
    description = "outbound traffic to Internet"
    from_port   = var.https_traffic
    to_port     = var.https_traffic
    protocol    = var.protocol
  }

  tags = {
    Name = "allow_ssh_and_internet_traffic"
  }
}


/* Resource block for creating EC2 instance AMI specific to us-eas-1 (North Virgina) region. 
You are allowed to select your instance type and the instance number on if statement. 
Instance will be deployed in private instance and security group above will apply it. 
Finally a local provisioner is used to output the instance public ip created to a local .txt file */
resource "aws_instance" "kashinstance" {
  ami             = "ami-0c94855ba95c71c99"
  instance_type   = var.kashinstance
  count = var.insNumber == "prod" ? 1 : 0
  subnet_id       = aws_subnet.kashprivate.id
  security_groups = ["${aws_security_group.kashSG.id}"]
  tags = {
    Name = "kashinstance"
  }

 provisioner "local-exec" {
   command = "echo ${self.public_ip} > public-ip.txt"
 
  }

}

/* Using for-each loop to create designated iam users */
resource "aws_iam_user" "kashUser"{
  for_each = toset (var.users)
  name = each.value
  }
