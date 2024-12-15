resource "aws_lb" "lb" {
  count                            = var.manage_load_balancer ? 1 : 0
  name                             = local.lb_name
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = [for subnet in aws_subnet.public : subnet.id]
  security_groups                  = [aws_security_group.lb[0].id]
  enable_deletion_protection       = var.enable_deletion_protection_on_load_balancer
  enable_cross_zone_load_balancing = true
  drop_invalid_header_fields       = true

  dynamic "access_logs" {
    for_each = var.enable_load_balancer_access_logs ? [1] : []
    content {
      bucket  = var.manage_s3_bucket_for_load_balancer ? aws_s3_bucket.this[0].bucket : var.load_balancer_access_logs_bucket
      prefix  = var.load_balancer_access_logs_prefix
      enabled = true
    }
  }

  lifecycle {
    precondition {
      condition     = alltrue([var.enable_load_balancer_access_logs, anytrue([var.manage_s3_bucket_for_load_balancer, length(var.load_balancer_access_logs_bucket) > 0])])
      error_message = "The load balancer access logs bucket must be set when enable_load_balancer_access_logs is true"
    }
  }

  depends_on = [aws_s3_bucket_policy.this]
}

resource "aws_security_group" "lb" {
  count       = var.manage_load_balancer ? 1 : 0
  vpc_id      = aws_vpc.main.id
  description = "The security group for the load balancer"
  ingress {
    #checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80" - public load balancer, which is redirected to HTTPS on LB level
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from any IP address
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from any IP address
  }

  egress {
    #checkov:skip=CKV_AWS_382: "Ensure no security groups allow egress from 0.0.0.0:0 to port -1"  - public load balancer
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow to any IP address
  }

  tags = merge(var.tags, {
    Name = "Load Balancer"
  })
}

resource "aws_lb_target_group" "app_target_group" {
  count    = var.manage_load_balancer ? 1 : 0
  name     = "${var.environment}-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTPS"
    port                = "443"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http_to_https" {
  count             = var.manage_load_balancer ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      protocol    = "HTTPS"
      port        = 443
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  count             = var.manage_load_balancer ? 1 : 0
  load_balancer_arn = aws_lb.lb[0].arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.use_acm_certificate ? aws_acm_certificate.cert[0].arn : var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group[0].arn
  }
}

resource "aws_acm_certificate" "cert" {
  count             = var.use_acm_certificate ? 1 : 0
  domain_name       = var.acm_domain_name
  validation_method = "DNS"

  validation_option {
    domain_name       = var.acm_domain_name
    validation_domain = var.acm_validation_domain_name
  }

  lifecycle {
    create_before_destroy = true

    precondition {
      condition     = alltrue([var.use_acm_certificate, length(var.acm_domain_name) > 0])
      error_message = "The ACM certificate domain name must be set when use_acm_certificate is true"
    }

    precondition {
      condition     = alltrue([var.use_acm_certificate, length(var.acm_validation_domain_name) > 0])
      error_message = "The ACM certificate validation domain name must be set when use_acm_certificate is true"
    }
  }

  tags = var.tags
}
