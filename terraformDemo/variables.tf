variable "kashregion" {
    type = string
    description = "VPC region"
}

variable "kashinstance" {
    type = string
    description = "instance type"
}

variable "insNumber" {}

variable "users" {
    description = "iam users"
    type = list
    default = ["kash" , "emanuel" , "lajarrid"]
}

variable "create_eip" {}

variable "ssh_traffic" {
    description = "ssh port"
    type = number
    default = 22
}

variable "https_traffic" {
    description = "ssh port"
    type = number
    default = 443
}

variable "protocol" {
    description = "TCP OR UDP"
    type = string
    default = "tcp"
}