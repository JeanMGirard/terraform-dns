#terraform {
#  experiments      = [module_variable_optional_attrs]
#}




resource "azurerm_private_dns_zone" "main" {
  count               = local.create_private_zone ? 1 : 0
  name                = local.zone_name
  resource_group_name = local.resource_group_name
  tags                = local.all_tags
}


# A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
resource "azurerm_private_dns_a_record" "main" {
  depends_on          = [data.azurerm_private_dns_zone.main]
  count               = local.is_private_zone ? length(local.a_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.all_tags

  name    = lookup(local.records[local.a_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.a_keys[count.index]], "ttl", 300)
  records = lookup(local.records[local.a_keys[count.index]], "records", [])
}


resource "azurerm_private_dns_aaaa_record" "main" {
  depends_on          = [data.azurerm_private_dns_zone.main]
  count               = local.is_private_zone ? length(local.aaaa_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.all_tags

  name    = lookup(local.records[local.aaaa_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.aaaa_keys[count.index]], "ttl", 300)
  records = lookup(local.records[local.aaaa_keys[count.index]], "records", [])
}

resource "azurerm_private_dns_cname_record" "main" {
  depends_on          = [data.azurerm_private_dns_zone.main]
  count               = local.is_private_zone ? length(local.cname_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.all_tags

  name   = lookup(local.records[local.cname_keys[count.index]], "name", "")
  ttl    = lookup(local.records[local.cname_keys[count.index]], "ttl", 3600)
  record = one(lookup(local.records[local.cname_keys[count.index]], "records", []))
}

resource "azurerm_private_dns_mx_record" "main" {
  depends_on          = [data.azurerm_private_dns_zone.main]
  count               = local.is_private_zone ? length(local.mx_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.all_tags
  name                = lookup(local.records[local.mx_keys[count.index]], "name", "")

  ttl = lookup(local.records[local.mx_keys[count.index]], "ttl", 3600)

  dynamic "record" {
    for_each = lookup(local.records[local.mx_keys[count.index]], "records", [])
    content {
      preference = lookup(record.value, "preference", 10)
      exchange   = lookup(record.value, "exchange", "")
    }
  }
}


resource "azurerm_private_dns_ptr_record" "main" {
  depends_on          = [data.azurerm_private_dns_zone.main]
  count               = local.is_private_zone ? length(local.ptr_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.all_tags

  name    = lookup(local.records[local.ptr_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.ptr_keys[count.index]], "ttl", 300)
  records = lookup(local.records[local.ptr_keys[count.index]], "records", [])
}

resource "azurerm_private_dns_srv_record" "main" {
  depends_on          = [data.azurerm_private_dns_zone.main]
  count               = local.is_private_zone ? length(local.srv_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  name                = lookup(local.records[local.srv_keys[count.index]], "name", "")
  tags                = local.all_tags

  ttl = lookup(local.records[local.srv_keys[count.index]], "ttl", 300)

  dynamic "record" {
    for_each = lookup(local.records[local.srv_keys[count.index]], "records", [])
    content {
      priority = lookup(record.value, "priority", 1)
      weight   = lookup(record.value, "weight", 5)
      port     = lookup(record.value, "port", 80)
      target   = lookup(record.value, "target", "")
    }
  }
}


resource "azurerm_private_dns_txt_record" "main" {
  depends_on = [data.azurerm_private_dns_zone.main]
  count      = local.is_private_zone ? length(local.txt_keys) : 0
  # { for ref, record in local.records : ref => record if record["type"] == "TXT" }
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  name                = lookup(local.records[local.txt_keys[count.index]], "name", "")
  tags                = local.all_tags

  ttl = lookup(local.records[local.txt_keys[count.index]], "ttl", 3600)

  dynamic "record" {
    for_each = lookup(local.records[local.txt_keys[count.index]], "records", [])
    content {
      value = record.value
    }
  }
}
