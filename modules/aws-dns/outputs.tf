# This is where you put your outputs declaration


output "parent_zone_id" {
  value       = local.parent_zone_id
  description = "ID of the hosted zone to contain this record"
}
output "parent_zone_name" {
  value       = one(data.aws_route53_zone.parent_info.*.name)
  description = "Name of the hosted zone to contain this record"
}


output "zone_id" {
  value       = join("", aws_route53_zone.default.*.zone_id)
  description = "Route53 DNS Zone ID"
}

output "zone_name" {
  value       = replace(join("", aws_route53_zone.default.*.name), "/\\.$/", "")
  description = "Route53 DNS Zone name"
}

output "zone_name_servers" {
  value       = try(aws_route53_zone.default[0].name_servers, [])
  description = "Route53 DNS Zone Name Servers"
}

output "fqdn" {
  value       = join("", aws_route53_zone.default.*.name)
  description = "Fully-qualified domain name"
}
#output "certificate" {
#  value       = one(module.cert.*.result)
#  description = "Certificate information"
#}
output "records" {
  value       = aws_route53_record.records
  description = "DNS Records."
}
