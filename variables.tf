variable "region" {
  description = "AWS Region"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "subnet" {
  description = "CIDR block for the subnet"
}

variable "private_ip" {
  description = "Private IP address for the network interface"
}

variable "instance_type" {
  description = "EC2 instance type"
}
