terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-static-website-sergiprat"
    key    = "static-website/terraform.tfstate"
    region = "eu-west-3"
  }
}

# Main provider - eu-west-3 for most resources
provider "aws" {
  region = var.aws_region
}

# Secondary provider - us-east-1 required for ACM + CloudFront
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}