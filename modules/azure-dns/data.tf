
data "azurerm_dns_zone" "parent" {
  count = var.parent_zone_name == null ? 0 : 1
  name  = var.parent_zone_name
}


data "azurerm_dns_zone" "main" {
  count               = local.is_public_zone ? 1 : 0
  depends_on          = [azurerm_dns_zone.main]
  name                = var.zone_name
  resource_group_name = lookup(local.resource_group, "name", null)

  timeouts {
    read = "2m"
  }
}
data "azurerm_private_dns_zone" "main" {
  count = local.is_private_zone ? 1 : 0
  depends_on          = [azurerm_private_dns_zone.main]
  name                = var.zone_name
  resource_group_name = lookup(local.resource_group, "name", null)

  timeouts {
    read = "2m"
  }
}
