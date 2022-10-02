data "aws_route53_zone" "parent" {
  count = local.has_parent && var.parent_zone_id == null ? local.parent_zone_enabled : 0
  name  = var.parent_zone_name
}
data "aws_route53_zone" "parent_info" {
  count   = local.has_parent ? local.parent_zone_enabled : 0
  zone_id = var.parent_zone_id == null ? one(data.aws_route53_zone.parent.*.id) : var.parent_zone_id
}


