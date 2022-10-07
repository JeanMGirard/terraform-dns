
locals {
  out_zone_name           = local.is_public_zone ? one(data.azurerm_dns_zone.main.*.name) : one(data.azurerm_private_dns_zone.main.*.name)
  out_zone_id             = local.is_public_zone ? one(data.azurerm_dns_zone.main.*.id) : one(data.azurerm_private_dns_zone.main.*.id)
}
output "resource_group_id" {
  value = local.resource_group_id
}
output "resource_group_name" {
  value = lookup(local.resource_group, "name", null)
}
output "zone_name" {
  value = local.out_zone_name
}
output "zone_id" {
  value = local.out_zone_id
}
output "is_private" {
  value = false
}
output "records" {
  value = local.records
}
