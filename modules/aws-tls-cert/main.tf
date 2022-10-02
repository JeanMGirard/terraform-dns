# This is where you put your resource declaration



data "aws_route53_zone" "zone_id" {
  count        = (local.specified_name && !local.specified_id) ? 1 : 0
  name         = var.zone_name
  private_zone = false
}
data "aws_route53_zone" "zone_name" {
  count        = (!local.specified_name && local.specified_id) ? 1 : 0
  name         = var.zone_id
  private_zone = false
}


locals {
  zone_id   = local.specified_id ? var.zone_id : one(data.aws_route53_zone.zone_id.*.id)
  zone_name = local.specified_name ? var.zone_name : one(data.aws_route53_zone.zone_name.*.name)
}

resource "aws_acm_certificate" "main" {
  count                     = local.enabled
  domain_name               = local.zone_name
  validation_method         = "DNS"
  subject_alternative_names = var.alt_names
  tags                      = lookup(local.meta, "tags", {})

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "dns_validation" {
  for_each = {
    for dvo in one(aws_acm_certificate.main.*.domain_validation_options) : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = lookup(each.value, "name", each.key)
  records = [lookup(each.value, "record", each.key)]
  type    = lookup(each.value, "type", each.key)

  allow_overwrite = true
  ttl             = 60
  zone_id         = local.zone_id

  #  for_each = {  for i, en in distinct(concat([var.zone_name], local.valid_alt_names)) : "${var.zone_name}_${i}" => try(element(local.validation_options, i), null) }
  #  count = try(length(one(aws_acm_certificate.main.*.domain_validation_options)), 0)
  #  for_each = {for i, dvo in try(aws_acm_certificate.main[0].domain_validation_options, toset([])) : "${dvo.domain_name}_${i}" => try(element(local.validation_options, i), null) }
  #  for_each = { for dvo in toset(flatten([for opt in aws_acm_certificate.main.*.domain_validation_options : tolist(opt)])) : dvo.domain_name => dvo }

  #  name    = element(aws_acm_certificate.main[0].domain_validation_options.*.resource_record_name, count.index)
  #  type    = element(aws_acm_certificate.main[0].domain_validation_options.*.resource_record_type, count.index)
  #  records = [element(aws_acm_certificate.main[0].domain_validation_options.*.resource_record_value, count.index)]
}
resource "aws_acm_certificate_validation" "validations" {
  count                   = length(aws_acm_certificate.main)
  certificate_arn         = aws_acm_certificate.main[count.index].arn
  validation_record_fqdns = [for record in aws_route53_record.dns_validation : record.fqdn]
  # validation_record_fqdns = [for record in merge(aws_route53_record.dns_validation, aws_route53_record.dns_validation, aws_route53_record.last_mile_apex_acm_validation, aws_route53_record.last_mile_environment_acm_validation) : record.fqdn]
}
