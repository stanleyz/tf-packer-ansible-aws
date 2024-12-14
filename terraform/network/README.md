<!-- BEGIN_TF_DOCS -->
# Overview

This module manages the AWS VPC and Load balancer if enabled.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.18 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.18 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |
## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http_to_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.app_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_security_group.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.load_balancer_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | The CIDR blocks for the private subnets | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidr_blocks"></a> [public\_subnet\_cidr\_blocks](#input\_public\_subnet\_cidr\_blocks) | The CIDR blocks for the public subnets | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_acm_domain_name"></a> [acm\_domain\_name](#input\_acm\_domain\_name) | The domain name for the ACM certificate | `string` | `""` | no |
| <a name="input_acm_validation_domain_name"></a> [acm\_validation\_domain\_name](#input\_acm\_validation\_domain\_name) | The domain name for the ACM certificate validation | `string` | `""` | no |
| <a name="input_enable_deletion_protection_on_load_balancer"></a> [enable\_deletion\_protection\_on\_load\_balancer](#input\_enable\_deletion\_protection\_on\_load\_balancer) | Whether to enable deletion protection for the load balancer | `bool` | `false` | no |
| <a name="input_enable_load_balancer_access_logs"></a> [enable\_load\_balancer\_access\_logs](#input\_enable\_load\_balancer\_access\_logs) | Whether to enable access logs for the load balancer | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the VPC | `string` | `"dev"` | no |
| <a name="input_load_balancer_access_logs_bucket"></a> [load\_balancer\_access\_logs\_bucket](#input\_load\_balancer\_access\_logs\_bucket) | The bucket for the load balancer access logs | `string` | `""` | no |
| <a name="input_load_balancer_access_logs_prefix"></a> [load\_balancer\_access\_logs\_prefix](#input\_load\_balancer\_access\_logs\_prefix) | The prefix for the load balancer access logs | `string` | `null` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | The name of the load balancer | `string` | `""` | no |
| <a name="input_manage_load_balancer"></a> [manage\_load\_balancer](#input\_manage\_load\_balancer) | Whether to manage the load balancer | `bool` | `true` | no |
| <a name="input_manage_s3_bucket_for_load_balancer"></a> [manage\_s3\_bucket\_for\_load\_balancer](#input\_manage\_s3\_bucket\_for\_load\_balancer) | Whether to manage an S3 bucket for the load balancer access logs | `bool` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket for the load balancer access logs | `string` | `""` | no |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The ARN of the SSL certificate for the load balancer | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_use_acm_certificate"></a> [use\_acm\_certificate](#input\_use\_acm\_certificate) | Whether to use an ACM certificate for the load balancer | `bool` | `true` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_load_balancer_dns_name"></a> [load\_balancer\_dns\_name](#output\_load\_balancer\_dns\_name) | n/a |
| <a name="output_load_balancer_security_group_id"></a> [load\_balancer\_security\_group\_id](#output\_load\_balancer\_security\_group\_id) | n/a |
| <a name="output_load_balancer_target_group_arn"></a> [load\_balancer\_target\_group\_arn](#output\_load\_balancer\_target\_group\_arn) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | n/a |
<!-- END_TF_DOCS -->