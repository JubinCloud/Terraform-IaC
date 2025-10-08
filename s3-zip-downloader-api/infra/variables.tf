variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Project name prefix"
  type        = string
  default     = "s3-zip-downloader"
}
