# This is where you put your outputs declaration

output "result" {
  value = one([
    for cert in aws_acm_certificate.main : {
      id            = cert.id
      arn           = cert.arn
      status        = cert.status
      domain_name   = cert.domain_name
      alt_names     = cert.subject_alternative_names
      authority_arn = cert.certificate_authority_arn
      chain         = cert.certificate_chain
      options       = merge(cert.options...)
      body          = cert.certificate_body
      tags          = cert.tags_all
    }
  ])
}
output "validation" {
  value = one([
    for cert in aws_acm_certificate.main : {
      method = cert.validation_method
      emails = cert.validation_emails
      records = [
        for record in aws_route53_record.dns_validation : {
          name   = record.name
          type   = record.type
          id     = record.id
          ttl    = record.ttl
          fqdn   = record.fqdn
          values = record.records
        }
      ]
      results = one(aws_acm_certificate_validation.validations)
    }
  ])
}
