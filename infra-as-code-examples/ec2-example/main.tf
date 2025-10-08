provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 in us-east-1
  instance_type = "t2.micro"
  tags = {
    Name = "iac-ec2-example"
  }
}
