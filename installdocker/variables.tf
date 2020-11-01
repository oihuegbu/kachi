variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "docker_vpc_cidr"{
    type = string
    default = "10.0.0.0/16"
}

variable "docker_subnet_cidr" {
    type = string
    default = "10.0.1.0/24"
}

variable "ssh_port" {
    type = number
    default = 22
}

variable "https_port" {
    type = number
    default = 443
}

variable "http_port" {
    type = number
    default = 80
}

variable "jenkins_port" {
    type = number
    default = 8080
}

variable "protocol_type" {
    type = string
    default = "tcp"
}

variable "allow_all_blocks" {
    type = string
    default = "0.0.0.0/0"
}


variable "ami_id" {
    type = string
    default = "ami-0c94855ba95c71c99"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "remote_exec_type" {
    type = string
    default = "ssh"
}

variable "remote_exec_user" {
    type = string
    default = "ec2-user"
}