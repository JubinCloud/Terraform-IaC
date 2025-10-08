variable "region" { type = string; default = "us-east-1" }
variable "name"   { type = string }
variable "vpc_cidr" { type = string; default = "10.0.0.0/16" }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "azs" { type = list(string) }
