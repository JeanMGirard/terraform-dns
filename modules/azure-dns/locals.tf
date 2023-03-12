locals {
  is_public_zone    = !var.is_private
  is_private_zone   = var.is_private
  resource_group_id = var.resource_group_id == null ? one(data.azurerm_resource_group.main.*.id) : var.resource_group_id
  resource_group    = var.resource_group_id == null ? {} : regex("/subscriptions/(?P<subscription_id>[^\\/]*)/resourceGroups/(?P<name>[^\\/]*)", local.resource_group_id)
  parent_zone       = var.parent_zone_id == null ? null : regex("/subscriptions/(?P<subscription_id>[^\\/]*)/resourceGroups/(?P<resource_group_name>[^\\/]*)/providers/Microsoft.Network/dnsZones/(?P<name>[^\\/]*)", var.parent_zone_id)
  dns_zone          = var.zone_id == null ? null : regex((local.is_private_zone
  ? "/subscriptions/(?P<subscription_id>[^\\/]*)/resourceGroups/(?P<resource_group_name>[^\\/]*)/providers/Microsoft.Network/dnsZones/(?P<name>[^\\/]*)"
  : "/subscriptions/(?P<subscription_id>[^\\/]*)/resourceGroups/(?P<resource_group_name>[^\\/]*)/providers/Microsoft.Network/dnsZones/(?P<name>[^\\/]*)"
  ), var.zone_id)

  empty_record = {
    name            = null
    enabled         = true
    type            = null
    ttl             = null
    allow_overwrite = null
    records         = []
  }
  txt_keys   = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "TXT", false)
  ])
  cname_keys = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "CNAME", false)
  ])
  a_keys     = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "A", false)
  ])
  aaaa_keys  = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "AAAA", false)
  ])
  caa_keys   = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "CAA", false)
  ])
  mx_keys    = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "MX", false)
  ])
  naptr_keys = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "NAPTR", false)
  ])
  ns_keys    = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "NS", false)
  ])
  ptr_keys   = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "PTR", false)
  ])
  soa_keys   = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "SOA", false)
  ])
  srv_keys   = tolist([
    for k, v in var.records : k if try((lookup(v, "enabled", true) != false) && upper(v["type"]) == "SRV", false)
  ])

  records = {
    for ref, record in var.records : ref => merge(record, {
      name          = try(coalesce(lookup(record, "name", null)), (substr(ref, 0, 1) == "@" ? "@" : ref))
      type          = try(upper(lookup(record, "type", "CNAME")), "CNAME")
      # records = toset(try(lookup(record, "records", []), []))
      records_range = toset(range(length(try(lookup(record, "records", []), []))))
    })
  }

  create_public_zone  = var.create_zone && (!can(coalesce(var.zone_id))) && local.is_public_zone
  create_private_zone = var.create_zone && (!can(coalesce(var.zone_id))) && local.is_private_zone
  zone_name           = var.zone_name



  resource_group_name = lookup(local.resource_group, "name", null)
}
