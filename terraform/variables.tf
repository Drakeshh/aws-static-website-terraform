variable "aws_region" {
  description = "Primary AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for the website"
  type        = string
}

variable "domain_name" {
  description = "Your custom domain name (e.g. mysite.com)"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}