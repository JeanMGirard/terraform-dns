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
  create_parent_zone_record = false # alltrue([local.is_aws, local.is_aws_parent, var.create_parent_zone_record])

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
  create_parent_zone_record = alltrue([local.is_az, local.is_az_parent, var.create_parent_zone_record])

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
locals {
  parent_name = local.is_az_parent ? local.az_parent_name : local.aws_parent_name

  # az_parent_info          = local.is_az_parent ? regex(local.regx.az_dns_zone, local.parent_id) : null
  az_parent_info  = local.is_az_parent ? regex("/subscriptions/(?P<subscription_id>[^\\/]*)/resourceGroups/(?P<resource_group_name>[^\\/]*)/providers/Microsoft.Network/dnszones/(?P<name>[^\\/]*)", "/subscriptions/221ff291-4cbe-43bf-97e1-55ea5fed42e7/resourceGroups/JeanMGirard/providers/Microsoft.Network/dnszones/jeanmgirard.com") : null
  az_parent_name  = local.is_az_parent ? lookup(local.az_parent_info, "name", null) : null
  az_parent_group = local.is_az_parent ? lookup(local.az_parent_info, "resource_group_name", null) : null

  # TODO: AWS Parent implicit information
  aws_parent_name = local.is_aws_parent ? var.parent_zone_id : null
}

# Azure
# ============================================
resource "azurerm_dns_ns_record" "parent_az" {
  depends_on          = [module.aws]
  count               = alltrue([local.is_az_parent, local.create_cross_records]) ? 1 : 0
  zone_name           = local.az_parent_name
  resource_group_name = local.az_parent_group
  tags                = local.all_tags
  name                = replace(local.zone_name, ".${local.az_parent_name}", "")
  ttl                 = 3600
  records             = one(module.aws.*.name_servers)
}

# AWS
# ============================================
resource "aws_route53_record" "parent_ns" {
  depends_on      = [module.azure]
  count           = alltrue([local.is_aws_parent, local.create_cross_records]) ? 1 : 0
  allow_overwrite = true
  zone_id         = local.parent_id
  name            = var.zone_name
  ttl             = 172800
  type            = "NS"
  records         = one(module.azure.*.name_servers)
}

# ===============================================================================================
# =========
# ===============================================================================================
