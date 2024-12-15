resource "aws_instance" "ec2" {
  count = var.instance_count

  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  monitoring             = var.monitoring_enabled
  ebs_optimized          = var.ebs_optimized
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile   = var.create_instance_profile ? aws_iam_instance_profile.ec2_instance_profile[0].name : null
  user_data              = base64decode(var.user_data)

  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "app_lb_attachment" {
  count = var.add_to_load_balancer ? var.instance_count : 0

  target_group_arn = var.target_group_arn
  target_id        = aws_instance.ec2[count.index].id

  lifecycle {
    precondition {
      condition     = alltrue([var.add_to_load_balancer, length(var.target_group_arn) > 0])
      error_message = "The target group ARN must be set when add_to_load_balancer is true"
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  count = var.create_instance_profile ? 1 : 0
  name  = local.instance_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_security_group" "ec2" {
  vpc_id      = data.aws_subnet.current.vpc_id
  description = "The security group for the EC2 instances"

  dynamic "ingress" {
    for_each = length(var.load_balancer_security_group_id) > 0 ? [1] : []
    content {
      description     = "Allow traffic from the load balancer on port 443"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      security_groups = [var.load_balancer_security_group_id]
    }
  }
}

resource "aws_iam_role_policy" "ec2_permission_policy" {
  count = var.create_instance_profile ? 1 : 0
  name  = local.instance_role_policy_name
  role  = aws_iam_role.ec2_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for permission in var.instance_permissions : {
        Action   = permission.actions
        Effect   = permission.effect
        Resource = permission.resources
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  count = var.create_instance_profile ? 1 : 0
  name  = local.instance_profile_name
  role  = aws_iam_role.ec2_role[0].name

  tags = var.tags
}
