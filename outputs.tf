# This is where you put your outputs declaration


locals {
  dns_zones = concat(
    (local.is_aws ? [
      {
        zone_id   = one(module.aws.*.zone_id)
        zone_name = one(module.aws.*.zone_name)
        records   = var.records
      }
    ] : []),
    (local.is_az ? [
      {
        zone_id   = one(module.azure.*.zone_id)
        zone_name = one(module.azure.*.zone_name)
        records   = var.records
      }
    ] : [])
  )
}


output "dns_provider" {
  value = local.zone_provider
}
output "zone_id" {
  value = try(local.dns_zones[0]["zone_id"], null)
}
output "zone_name" {
  value = try(local.dns_zones[0]["zone_name"], null)
}

output "parent_provider" {
  value = local.parent_provider
}
output "parent_zone_id" {
  value = local.parent_id
}
output "parent_zone_name" {
  value = local.parent_name
}



#output "zone" {
#  value = {
#    id           = module.aws.zone_id
#    name         = module.aws.zone_name
#    name_servers = module.aws.name_servers
#    fqdn         = module.aws.fqdn
#    records      = module.aws.records
#    dns_provider = var.dns_provider
#    parent_zone = {
#      id   = module.aws.parent_zone_id
#      name = module.aws.parent_zone_name
#    }
#  }
#  description = "DNS Zone"
#}
