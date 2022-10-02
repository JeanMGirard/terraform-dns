locals {
  enabled = var.enabled && can(coalesce(var.zone.name))
  is_aws  = local.enabled && lower(var.dns_provider) == "aws"
  is_az   = local.enabled && lower(var.dns_provider) == "azure"
  is_gce  = local.enabled && lower(var.dns_provider) == "gce"

  has_parent = anytrue([var.parent_zone_id != null, var.parent_zone_name != null])
  parent = {
    id         = var.parent_zone_id
    name       = var.parent_zone_name
    add_record = true
    provider   = var.parent_zone_provider == null ? var.dns_provider : var.parent_zone_provider
  }
  zone = {
    alias     = lookup(var.zone, "alias", null)
    name      = lookup(var.zone, "name", null)
    id        = lookup(var.zone, "id", null)
    alt_names = lookup(var.zone, "alt_names", [])
    provider  = lookup(var.zone, "provider", null)
  }
  records = var.records
}
