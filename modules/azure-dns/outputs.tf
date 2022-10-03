
locals {
  out_zone_name           = local.is_public_zone ? one(data.azurerm_dns_zone.main.*.name) : one(data.azurerm_private_dns_zone.main.*.name)
  out_zone_id             = local.is_public_zone ? one(data.azurerm_dns_zone.main.*.id) : one(data.azurerm_private_dns_zone.main.*.id)
  out_resource_group_name = local.is_public_zone ? one(data.azurerm_dns_zone.main.*.resource_group_name) : one(data.azurerm_private_dns_zone.main.*.resource_group_name)
}

output "resource_group_name" {
  value = local.out_resource_group_name
}
output "zone_name" {
  value = local.out_zone_name
}
output "zone_id" {
  value = local.out_zone_id
}
output "is_private" {
  value = var.is_private
}
output "records" {
  value = local.records
}
