output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}

output "load_balancer_dns_name" {
  value = try(aws_lb.lb[0].dns_name, "")
}

output "load_balancer_target_group_arn" {
  value = try(aws_lb_target_group.app_target_group[0].arn, "")
}

output "load_balancer_security_group_id" {
  value = try(aws_security_group.lb[0].id, "")
}

output "s3_bucket_arn" {
  value = try(aws_s3_bucket.this[0].arn, "")
}