terraform {
  required_version = "~> 1.7.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.18"
    }
  }
}


provider "aws" {
  default_tags {
    tags = {
      owner = "stanley"
    }
  }
}