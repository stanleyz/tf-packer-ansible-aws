locals {
  lb_name        = length(var.load_balancer_name) > 0 ? var.load_balancer_name : "${var.environment}-lb"
  s3_bucket_name = length(var.s3_bucket_name) > 0 ? var.s3_bucket_name : "${var.environment}-lb-logs-${random_string.this.result}"

  aws_elb_account_ids = {
    "us-east-1"      = "127311923021"
    "us-east-2"      = "033677994240"
    "us-west-1"      = "027434742980"
    "us-west-2"      = "797873946194"
    "ap-northeast-1" = "582318560864"
    "ap-northeast-2" = "600734575887"
    "ap-south-1"     = "718504428378"
    "ap-southeast-1" = "114774131450"
    "ap-southeast-2" = "783225319266"
    "ca-central-1"   = "985666609251"
    "eu-central-1"   = "054676820928"
    "eu-west-1"      = "156460612806"
    "eu-west-2"      = "652711504416"
    "eu-west-3"      = "009996457667"
    "sa-east-1"      = "507241528517"
  }
}

data "aws_availability_zones" "available" {
}

data "aws_region" "current" {}

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
}
