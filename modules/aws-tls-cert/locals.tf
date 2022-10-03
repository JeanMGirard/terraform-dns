locals {
  enabled     = 1
  name        = lookup(local.meta, "name", null)
  description = lookup(local.meta, "description", null)

  specified_id    = var.zone_id != null && var.zone_id != ""
  specified_name  = var.zone_name != null && var.zone_name != ""
  valid_alt_names = [for name in var.alt_names : replace(name, "*.", "")]
}
