variable "environment" {
  description = "The environment for the VPC"
  type        = string
  default     = "dev"
}

variable "instance_count" {
  description = "The number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ami" {
  description = "The AMI to use for the EC2 instances"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs to use for the EC2 instances"
  type        = list(string)
}

variable "create_instance_profile" {
  description = "Whether to create an IAM instance profile for the EC2 instances"
  type        = bool
  default     = true
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile for the EC2 instances"
  type        = string
  default     = ""
}

variable "monitoring_enabled" {
  description = "Whether to enable detailed monitoring for the EC2 instances"
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "Whether to enable EBS optimization for the EC2 instances"
  type        = bool
  default     = false
}

variable "instance_role_policy_name" {
  description = "The name of the IAM role policy for the EC2 instances"
  type        = string
  default     = ""
}

variable "instance_role_name" {
  description = "The name of the IAM role for the EC2 instances"
  type        = string
  default     = ""
}

variable "instance_permissions" {
  description = "The permissions to attach to the IAM role for the EC2 instances"
  type = map(object({
    effect    = optional(string, "Alow")
    actions   = list(string)
    resources = list(string)
  }))
  default = {}
}

variable "add_to_load_balancer" {
  description = "Whether to add the EC2 instances to the load balancer"
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "The ARN of the target group to attach the EC2 instances to"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "The user data in base64 to use for the EC2 instances"
  type        = string
  default     = ""
}

variable "load_balancer_security_group_id" {
  description = "The ID of the security group for the load balancer"
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags to apply to all resources"
  type        = map(string)
  default     = {}
}
