locals {
  instance_profile_name     = length(var.instance_profile_name) > 0 ? var.instance_profile_name : "${var.environment}-ec2-profile"
  instance_role_name        = length(var.instance_role_name) > 0 ? var.instance_role_name : "${var.environment}-ec2-role"
  instance_role_policy_name = length(var.instance_role_policy_name) > 0 ? var.instance_role_policy_name : "${var.environment}-ec2-role-policy"
}

data "aws_subnet" "current" {
  id = var.subnet_ids[0]
}