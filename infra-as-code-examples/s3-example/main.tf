provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "iac-example-bucket-${random_id.rand.hex}"
  acl    = "private"

  tags = {
    Name = "iac-example-bucket"
  }
}

resource "random_id" "rand" {
  byte_length = 4
}
