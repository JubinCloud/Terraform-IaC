variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "secure-network"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "subnet_cidr" {
  default = "10.1.1.0/24"
}

variable "az" {
  default = "us-east-1a"
}
