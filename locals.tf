locals {
  enabled = var.enabled && can(coalesce(var.zone_name == null ? var.zone_id : var.zone_name))
  is_aws  = local.enabled && lower(var.dns_provider) == "aws"
  is_az   = local.enabled && lower(var.dns_provider) == "azure"
  is_gce  = local.enabled && lower(var.dns_provider) == "gce"

  has_parent = anytrue([var.parent_zone_id != null, var.parent_zone_name != null])

  parent_id       = var.parent_zone_id
  parent_name     = var.parent_zone_name
  parent_provider = var.parent_zone_provider == null ? var.dns_provider : var.parent_zone_provider

  zone_alias     = var.zone_alias
  zone_name      = var.zone_name
  zone_id        = var.zone_id
  zone_alt_names = var.alt_names
  zone_provider  = var.dns_provider

  records = var.records
}
