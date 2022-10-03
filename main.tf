terraform {
  required_version = ">= 1.1"
}

module "aws" {
  count      = local.is_aws ? 1 : 0
  source     = "./modules/aws-dns"
  meta       = local.meta
  is_private = var.is_private

  parent_zone_id            = local.parent_id
  parent_zone_name          = local.parent_name
  create_parent_zone_record = local.parent_provider == "aws" ? var.create_parent_zone_record : false

  zone_id       = local.zone_id
  zone_name     = local.zone_name
  alt_names     = var.alt_names
  zone_alias    = local.zone_alias
  generate_cert = var.generate_cert
  records       = local.records
}


module "azure" {
  count      = local.is_az ? 1 : 0
  source     = "./modules/azure-dns"
  meta       = local.meta
  is_private = var.is_private

  parent_zone_id            = local.parent_id
  parent_zone_name          = local.parent_name
  create_parent_zone_record = local.parent_provider == "azure" ? var.create_parent_zone_record : false

  resource_group_id = var.resource_group_id
  resource_group_name = var.resource_group_name

  create_zone       = var.create_zone
  zone_id           = local.zone_id
  zone_name         = local.zone_name
  records           = local.records
}


