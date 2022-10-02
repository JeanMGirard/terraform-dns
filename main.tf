

module "aws" {
  count = local.is_aws ? 1 : 0
  source  = "./modules/aws-dns"
  meta    = local.meta
  enabled = local.is_aws

  parent_zone_id             = local.parent.id
  parent_zone_name           = local.parent.name
  parent_zone_record_enabled = local.parent.add_record

  zone_id       = local.zone.id
  zone_name     = local.zone.name
  alt_names     = local.zone.alt_names
  zone_alias    = local.zone.alias
  generate_cert = var.generate_cert
  records       = local.records
}


module "azure" {
  count = local.is_az ? 1 : 0
  source  = "./modules/azure-dns"
  meta    = local.meta
  enabled = local.is_az
  is_private = var.is_private

  resource_group_id = var.resource_group_id
  create_zone = local.is_az ? var.create_zone : false
  zone_id     = local.is_az ? local.zone.id : null
  zone_name   = local.is_az ? local.zone.name : null
  records     = local.is_az ? local.records : {}

  parent_zone_id             = local.is_az ? local.parent.id : null
  parent_zone_name           = local.is_az ? local.parent.name : null
  parent_zone_record_enabled = local.is_az ? local.parent.add_record : null
}


