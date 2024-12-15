locals {
  acm_domain_name = "test.ityin.net"
}

module "network" {
  source = "../../terraform/network"

  vpc_cidr_block             = "10.10.0.0/16"
  public_subnet_cidr_blocks  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnet_cidr_blocks = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  enable_deletion_protection_on_load_balancer = true
  acm_domain_name                             = local.acm_domain_name
  acm_validation_domain_name                  = "ityin.net"
}

module "ec2" {
  source = "../../terraform/ec2"

  instance_count = 1
  ami            = "ami-01e286af3efa684cb"
  subnet_ids     = [for i in module.network.private_subnets : i.id]

  ebs_optimized      = true
  monitoring_enabled = true

  add_to_load_balancer            = true
  target_group_arn                = module.network.load_balancer_target_group_arn
  load_balancer_security_group_id = module.network.load_balancer_security_group_id

  instance_permissions = {
    "access_s3" = {
      effect    = "Allow"
      actions   = ["s3:GetObject"]
      resources = [module.network.s3_bucket_arn]
    }
  }
}
