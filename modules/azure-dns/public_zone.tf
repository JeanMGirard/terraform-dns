
#terraform {
#  experiments      = [module_variable_optional_attrs]
#}


resource "azurerm_dns_ns_record" "parent" {
  depends_on          = [azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(data.azurerm_dns_zone.parent) : 0
  zone_name           = one(data.azurerm_dns_zone.parent.*.name)
  resource_group_name = one(data.azurerm_dns_zone.parent.*.resource_group_name)
  tags                = local.tags

  name    = replace(var.zone_name, ".${one(data.azurerm_dns_zone.parent.*.name)}", "")
  ttl     = 3600
  records = one(data.azurerm_dns_zone.main.*.name_servers)
}


resource "azurerm_dns_zone" "main" {
  depends_on          = [data.azurerm_dns_zone.parent]
  count               = local.create_public_zone ? 1 : 0
  name                = local.zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags
}



# A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
resource "azurerm_dns_a_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.a_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags

  name    = lookup(local.records[local.a_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.a_keys[count.index]], "ttl", 300)
  records = lookup(local.records[local.a_keys[count.index]], "records", [])
}


resource "azurerm_dns_aaaa_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.aaaa_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags

  name    = lookup(local.records[local.aaaa_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.aaaa_keys[count.index]], "ttl", 300)
  records = lookup(local.records[local.aaaa_keys[count.index]], "records", [])
}

resource "azurerm_dns_caa_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.caa_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags

  name = lookup(local.records[local.caa_keys[count.index]], "name", "")
  ttl  = lookup(local.records[local.caa_keys[count.index]], "ttl", 3600)

  dynamic "record" {
    for_each = lookup(local.records[local.caa_keys[count.index]], "records", [])
    content {
      flags = lookup(record.value, "flags", 0)
      tag   = lookup(record.value, "tag", "")
      value = lookup(record.value, "value", "")
    }
  }
}

resource "azurerm_dns_cname_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.cname_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags

  name   = lookup(local.records[local.cname_keys[count.index]], "name", "")
  ttl    = lookup(local.records[local.cname_keys[count.index]], "ttl", 3600)
  record = one(lookup(local.records[local.cname_keys[count.index]], "records", []))
}

resource "azurerm_dns_mx_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.mx_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags
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

resource "azurerm_dns_ns_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.ns_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags

  name    = lookup(local.records[local.ns_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.ns_keys[count.index]], "ttl", 3600)
  records = lookup(local.records[local.ns_keys[count.index]], "records", [])
}

resource "azurerm_dns_ptr_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.ptr_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags

  name    = lookup(local.records[local.ptr_keys[count.index]], "name", "")
  ttl     = lookup(local.records[local.ptr_keys[count.index]], "ttl", 300)
  records = lookup(local.records[local.ptr_keys[count.index]], "records", [])
}

resource "azurerm_dns_srv_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.srv_keys) : 0
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  name                = lookup(local.records[local.srv_keys[count.index]], "name", "")
  tags                = local.tags

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


resource "azurerm_dns_txt_record" "main" {
  depends_on          = [data.azurerm_dns_zone.main]
  count               = local.is_public_zone ? length(local.txt_keys) : 0 # { for ref, record in local.records : ref => record if record["type"] == "TXT" }
  zone_name           = local.out_zone_name
  resource_group_name = local.resource_group_name
  name                = lookup(local.records[local.txt_keys[count.index]], "name", "")
  tags                = local.tags

  ttl = lookup(local.records[local.txt_keys[count.index]], "ttl", 3600)

  dynamic "record" {
    for_each = lookup(local.records[local.txt_keys[count.index]], "records", [])
    content {
      value = record.value
    }
  }
}
