locals {
  enabled     = var.enabled && can(coalesce(var.zone_name)) ? 1 : 0
  name        = lookup(local.meta, "name", null)
  description = lookup(local.meta, "description", null)

  has_parent          = anytrue([var.parent_zone_id != null, var.parent_zone_name != null])
  parent_zone_name    = var.parent_zone_name
  parent_zone_enabled = var.parent_zone_record_enabled == false ? 0 : (local.has_parent ? 1 : 0)
  parent_zone_id      = var.parent_zone_id == null ? one(data.aws_route53_zone.parent.*.id) : var.parent_zone_id
  zone_name           = local.enabled >= 1 ? var.zone_name : ""
  zone_alias          = local.enabled >= 1 ? var.zone_alias : ""
  cert_count          = var.generate_cert ? local.enabled : 0


}
