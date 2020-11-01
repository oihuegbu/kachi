/* 
This demo installs a jenkins application within a docker container housed on an EC2 instance.
All variables are stored in the variables.tf folder.
I am also utilizing a remote backend on amazon S3, as to give me the liberty of using
terraform on any platform.
REMOTE EXEC SHOULD always BE USED AS A LAST RESORT (this demo shows how to do so, if necessary).
A better solution would be to use the user-data feature to bootstrap yup updates,
docker and jenkins installation
*/

#Cloud provider and region.
provider "aws" {
    region = var.aws_region
}

#VPC used.
resource "aws_vpc" "dockervpc" {
    cidr_block = var.docker_vpc_cidr
    tags = {
      "Name" = "dockervpc"
    }
}

#Internet Gateway which gives the VPC access to the internet.
resource "aws_internet_gateway" "dockerigw" {
    vpc_id = aws_vpc.dockervpc.id
    tags = {
      "Name" = "dockerIGW"
    }  
}

#Route table which connects the subnet containing the EC2 instance to the Internet Gateway.
resource "aws_route_table" "docker_route" {
  vpc_id = aws_vpc.dockervpc.id

  route {
  cidr_block = var.allow_all_blocks
  gateway_id = aws_internet_gateway.dockerigw.id
  }

  tags = {
    "Name" = "docker_public_route"
  }
}

#Resource block that connects the subnet to the route table.
resource "aws_route_table_association" "docker_association" {
  subnet_id = aws_subnet.dockersubnet.id
  route_table_id = aws_route_table.docker_route.id
}

#Public subnet housing the docker container.
resource "aws_subnet" "dockersubnet" {
  vpc_id     = aws_vpc.dockervpc.id
  cidr_block = var.docker_subnet_cidr
  map_public_ip_on_launch = "true"


  tags = {
    Name = "dockerPublicsubnet"
  }
}

#Security Group allowing traffic to and form SSH port, hppts port, http port and jenkins port.
#All with the tcp protocol.
resource "aws_security_group" "dockerSG" {
  name        = "dockerSG"
  description = "Allow traffic"
  vpc_id      = aws_vpc.dockervpc.id

  ingress {
    description = "inbound traffic from SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  ingress {
    description = "inbound traffic from internet"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  ingress {
    description = "inbound traffic to yum"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  ingress {
    description = "inbound traffic to docker port 8080"
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  egress {
    description = "outbound traffic to SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  egress {
    description = "outbound traffic to Internet"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  egress {
    description = "outbound traffic to yum"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  egress {
    description = "outbound traffic to docker port 8080"
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = var.protocol_type
    cidr_blocks = [var.allow_all_blocks]
  }

  tags = {
    Name = "allow_ssh_&_internet_traffic_&_docker_port"
  }
}

#EC2 instance with .pem key stored in my local file.
resource "aws_instance" "docker_instance"{
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.dockersubnet.id
  vpc_security_group_ids = [aws_security_group.dockerSG.id]
  associate_public_ip_address = true
  key_name = "kashmoney"
  
/*Remote-exec bootstrapping yum updates, then docker installation, then jenkins installation on docker
and finally attaching the port 8080 to jenkins app.*/
    provisioner "remote-exec" {
    connection {
    type = var.remote_exec_type
    user = var.remote_exec_user
    host = aws_instance.docker_instance.public_ip
    private_key = file("./kashmoney.pem")
    agent = false
    timeout = "1m"
  }
    
    on_failure = continue
    

   inline = [
             "sudo yum update -y",
             "sudo yum install docker -y",
             "sudo systemctl start docker",
             "sudo service docker start",
             "sudo docker pull jenkins/jenkins",
             "sudo docker run -p 8080:8080 jenkins/jenkins",
   ]
 
  }
   
}

