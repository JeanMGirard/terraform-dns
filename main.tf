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

  resource_group_id   = var.resource_group_id
  resource_group_name = var.resource_group_name

  create_zone = var.create_zone
  zone_id     = local.zone_id
  zone_name   = local.zone_name
  records     = local.records
}



# ===============================================================================================
# ========= Parent Records for secondary provider ===============================================
# ===============================================================================================

# Azure
# ============================================
data "azurerm_dns_zone" "parent_az" {
  count               = (local.create_cross_records && local.parent_provider == "azure") ? 1 : 0
  name                = local.parent_name
  resource_group_name = local.parent_id
}
resource "azurerm_dns_ns_record" "parent_az" {
  depends_on          = [module.aws]
  count               = (local.create_cross_records && local.parent_provider == "azure") ? 1 : 0
  zone_name           = local.parent_name
  resource_group_name = local.parent_id
  tags                = local.all_tags
  name                = replace(var.zone_name, ".${one(data.azurerm_dns_zone.parent_az.*.name)}", "")
  ttl                 = 3600
  records             = one(module.aws.*.zone_name_servers)
}

# AWS
# ============================================
#data "aws_route53_zone" "parent" {
#  count = local.has_parent && var.parent_zone_id == null ? local.parent_zone_enabled : 0
#  name  = var.parent_zone_name
#}
#data "aws_route53_zone" "parent_info" {
#  count   = local.has_parent ? local.parent_zone_enabled : 0
#  zone_id = var.parent_zone_id == null ? one(data.aws_route53_zone.parent.*.id) : var.parent_zone_id
#}
#resource "aws_rou" "parent_aws" {
#  depends_on          = [module.aws]
#  count               = (local.create_cross_records && local.parent_provider == "azure") ? 1 : 0
#  zone_name           = local.parent_name
#  resource_group_name = local.parent_id
#  tags                = local.all_tags
#  name    = replace(var.zone_name, ".${one(data.azurerm_dns_zone.parent_az.*.name)}", "")
#  ttl     = 3600
#  records = one(module.aws.*.zone_name_servers)
#}


# ===============================================================================================
# =========
# ===============================================================================================
