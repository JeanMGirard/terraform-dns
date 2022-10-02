# This is where you put your resource declaration


resource "aws_route53_zone" "default" {
  count = local.enabled
  name  = var.zone_name
  # tags  = local.meta.tags
}


resource "aws_route53_record" "ns" {
  count   = local.parent_zone_enabled
  zone_id = local.parent_zone_id
  name    = join("", aws_route53_zone.default.*.name)
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.default[count.index].name_servers
}
resource "aws_route53_record" "soa" {
  count           = local.enabled
  allow_overwrite = true
  zone_id         = join("", aws_route53_zone.default.*.id)
  name            = join("", aws_route53_zone.default.*.name)
  type            = "SOA"
  ttl             = "30"

  records = [
    format("%s. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400", aws_route53_zone.default[0].name_servers[0])
  ]
}

# join("-", [join("", aws_route53_zone.default.*.name), each.key])

resource "aws_route53_record" "records" {
  for_each        = var.records
  zone_id         = join("", aws_route53_zone.default.*.id)
  name            = each.value.name
  allow_overwrite = each.value.allow_overwrite
  type            = each.value.type
  ttl             = each.value.ttl
  records         = each.value.records
}

module "cert" {
  count      = var.generate_cert ? 1 : 0
  enabled    = var.generate_cert
  depends_on = [aws_route53_zone.default]
  source     = "../dns-tls-cert"
  zone_name  = var.zone_name
  alt_names  = var.alt_names
  meta       = local.meta
}

