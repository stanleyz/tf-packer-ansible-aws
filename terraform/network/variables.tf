variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "environment" {
  description = "The environment for the VPC"
  type        = string
  default     = "dev"
}

variable "manage_load_balancer" {
  description = "Whether to manage the load balancer"
  type        = bool
  default     = true
}

variable "enable_deletion_protection_on_load_balancer" {
  description = "Whether to enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "enable_load_balancer_access_logs" {
  description = "Whether to enable access logs for the load balancer"
  type        = bool
  default     = true
}

variable "load_balancer_access_logs_bucket" {
  description = "The bucket for the load balancer access logs"
  type        = string
  default     = ""
}

variable "load_balancer_access_logs_prefix" {
  description = "The prefix for the load balancer access logs"
  type        = string
  default     = null
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  type        = string
  default     = ""
}

variable "manage_s3_bucket_for_load_balancer" {
  description = "Whether to manage an S3 bucket for the load balancer access logs"
  type        = bool
  default     = true
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for the load balancer access logs"
  type        = string
  default     = ""

}

variable "ssl_certificate_arn" {
  description = "The ARN of the SSL certificate for the load balancer"
  type        = string
  default     = null
}

variable "use_acm_certificate" {
  description = "Whether to use an ACM certificate for the load balancer"
  type        = bool
  default     = true
}

variable "acm_domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
  default     = ""
}

variable "acm_validation_domain_name" {
  description = "The domain name for the ACM certificate validation"
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags to apply to all resources"
  type        = map(string)
  default     = {}
}
