provider "aws" {
  region = var.region
}

resource "aws_vpc" "secure" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project}-secure-vpc"
  }
}

resource "aws_subnet" "secure_subnet" {
  vpc_id            = aws_vpc.secure.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.az
  tags = {
    Name = "${var.project}-secure-subnet"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP/HTTPS inbound"
  vpc_id      = aws_vpc.secure.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}
