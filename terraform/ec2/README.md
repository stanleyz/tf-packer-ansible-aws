<!-- BEGIN_TF_DOCS -->
# Overview

This module manages the AWS instance and the associated Instance profile if enabled.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.18 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.18 |
## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ec2_permission_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_instance.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_lb_target_group_attachment.app_lb_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use for the EC2 instances | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet IDs to use for the EC2 instances | `list(string)` | n/a | yes |
| <a name="input_add_to_load_balancer"></a> [add\_to\_load\_balancer](#input\_add\_to\_load\_balancer) | Whether to add the EC2 instances to the load balancer | `bool` | `false` | no |
| <a name="input_create_instance_profile"></a> [create\_instance\_profile](#input\_create\_instance\_profile) | Whether to create an IAM instance profile for the EC2 instances | `bool` | `true` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Whether to enable EBS optimization for the EC2 instances | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the VPC | `string` | `"dev"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of EC2 instances to create | `number` | `1` | no |
| <a name="input_instance_permissions"></a> [instance\_permissions](#input\_instance\_permissions) | The permissions to attach to the IAM role for the EC2 instances | <pre>map(object({<br>    effect    = optional(string, "Alow")<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | The name of the IAM instance profile for the EC2 instances | `string` | `""` | no |
| <a name="input_instance_role_name"></a> [instance\_role\_name](#input\_instance\_role\_name) | The name of the IAM role for the EC2 instances | `string` | `""` | no |
| <a name="input_instance_role_policy_name"></a> [instance\_role\_policy\_name](#input\_instance\_role\_policy\_name) | The name of the IAM role policy for the EC2 instances | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use for the EC2 instances | `string` | `"t2.micro"` | no |
| <a name="input_load_balancer_security_group_id"></a> [load\_balancer\_security\_group\_id](#input\_load\_balancer\_security\_group\_id) | The ID of the security group for the load balancer | `string` | `""` | no |
| <a name="input_monitoring_enabled"></a> [monitoring\_enabled](#input\_monitoring\_enabled) | Whether to enable detailed monitoring for the EC2 instances | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the target group to attach the EC2 instances to | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data in base64 to use for the EC2 instances | `string` | `""` | no |
## Outputs

No outputs.
<!-- END_TF_DOCS -->