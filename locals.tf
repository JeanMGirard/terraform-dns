locals {
  #  regx = {
  #    az_dns_zone = "/subscriptions/(?P<subscription_id>[^\\/]*)/resourceGroups/(?P<resource_group_name>[^\\/]*)/providers/Microsoft.Network/dnszones/(?P<name>[^\\/]*)"
  #  }

  enabled = var.enabled && can(coalesce(var.zone_name == null ? var.zone_id : var.zone_name))
  is_aws  = local.enabled && lower(var.dns_provider) == "aws"
  is_az   = local.enabled && lower(var.dns_provider) == "azure"
  is_gce  = local.enabled && lower(var.dns_provider) == "gce"

  has_parent           = anytrue([var.parent_zone_id != null, var.create_parent_zone_record])
  is_cross_provider    = local.has_parent && local.parent_provider != var.dns_provider
  create_cross_records = alltrue([local.is_cross_provider, var.create_parent_zone_record])

  parent_id = var.parent_zone_id
  # parent_name          = var.parent_zone_name
  parent_provider = var.parent_zone_provider == null ? var.dns_provider : var.parent_zone_provider

  is_az_parent  = local.has_parent && local.parent_provider == "azure"
  is_aws_parent = local.has_parent && local.parent_provider == "aws"

  zone_alias     = var.zone_alias
  zone_name      = var.zone_name
  zone_id        = var.zone_id
  zone_alt_names = var.alt_names
  zone_provider  = var.dns_provider

  records = var.records
}
