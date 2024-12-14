output "load_balancer_dns_name" {
  value = module.network.load_balancer_dns_name
}

output "acm_domain_name" {
  value = local.acm_domain_name
}