# This is where you put your outputs declaration

output "zone_id" {
  value = module.aws.zone_id
}
output "zone_name" {
  value = module.aws.zone_name
}
output "dns_provider" {
  value = var.dns_provider
}
output "zone" {
  value = {
    id           = module.aws.zone_id
    name         = module.aws.zone_name
    name_servers = module.aws.zone_name_servers
    fqdn         = module.aws.fqdn
    records      = module.aws.records
    dns_provider = var.dns_provider
    parent_zone = {
      id   = module.aws.parent_zone_id
      name = module.aws.parent_zone_name
    }
  }
  description = "DNS Zone"
}
