#Defines AWS region
variable "aws_region" {
    type = string
    default = "us-east-1"
}

#Defines VPC cidr block
variable "docker_vpc_cidr"{
    type = string
    default = "10.0.0.0/16"
}

#Defines public subnet with cidr block within the VPC cidr
variable "docker_subnet_cidr" {
    type = string
    default = "10.0.1.0/24"
}

#Defines SSH port for yum updates
variable "ssh_port" {
    type = number
    default = 22
}

#Defines https port
variable "https_port" {
    type = number
    default = 443
}

#Defines http port
variable "http_port" {
    type = number
    default = 80
}

#Defines jenkins port to connect form the internet
variable "jenkins_port" {
    type = number
    default = 8080
}

#Defines the security group protocol of each port
variable "protocol_type" {
    type = string
    default = "tcp"
}

#Defines the IPV4 and subnet mask allowing all networks
variable "allow_all_blocks" {
    type = string
    default = "0.0.0.0/0"
}

#Defines the ami ID (this varies from region to region. This ID is specfiic to us-east-1.)
variable "ami_id" {
    type = string
    default = "ami-0c94855ba95c71c99"
}

#Defines the instance type
variable "instance_type" {
    type = string
    default = "t2.micro"
}

#Defines the type of connector
variable "remote_exec_type" {
    type = string
    default = "ssh"
}

#Defines the user type when you SSH into the instance
variable "remote_exec_user" {
    type = string
    default = "ec2-user"
}
