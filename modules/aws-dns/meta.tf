
variable "meta" {
  type    = any
  default = {}
}
locals {
  meta = var.meta

  tenant       = lookup(local.meta, "tenant", null)
  namespace    = lookup(local.meta, "namespace", null)
  project      = lookup(local.meta, "project", null)
  environment  = lookup(local.meta, "environment", null)
  stage        = lookup(local.meta, "stage", null)
  attributes   = lookup(local.meta, "attributes", {})
  default_tags = lookup(local.meta, "default_tags", {})
  tags         = lookup(local.meta, "tags", {})
  flags        = lookup(local.meta, "flags", [])
  iam_path     = lookup(local.meta, "iam_path", null)
  env          = lookup(local.meta, "env", null)
  random       = lookup(local.meta, "random", null)
}
output "meta" {
  value = local.meta
}
