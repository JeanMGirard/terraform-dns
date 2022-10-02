locals {
  enabled     = var.enabled ? 1 : 0
  name        = lookup(local.meta, "name", null)
  description = lookup(local.meta, "description", null)

  specified_id    = var.enabled && var.zone_id != null && var.zone_id != ""
  specified_name  = var.enabled && var.zone_name != null && var.zone_name != ""
  valid_alt_names = [for name in var.alt_names : replace(name, "*.", "")]
}
