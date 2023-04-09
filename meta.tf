/* 
  *****************************************************
    This file was generated!
    Edit at your own risks,you could loose your changes
  *****************************************************
*/

variable "meta" {
  type    = any
  default = {}
}
module "meta" {
  source = "git@github.com:JeanMGirard/terraform-meta.git"
  # source = "gitlab.com/Jean.M.Girard/meta/local"
  # version = "1.0.0"
}
#module "meta" {
#  source = "../../../libs/terraform/helpers/meta" # "git@github.com:JeanMGirard/terraform-meta.git"
#  meta   = var.meta
#}
locals {
  meta = module.meta

  tenant       = lookup(local.meta, "tenant", null)
  namespace    = lookup(local.meta, "namespace", null)
  project      = lookup(local.meta, "project", null)
  name         = lookup(local.meta, "name", null)
  description  = lookup(local.meta, "description", null)
  environment  = lookup(local.meta, "environment", null)
  stage        = lookup(local.meta, "stage", null)
  attributes   = lookup(local.meta, "attributes", {})
  tags         = lookup(local.meta, "tags", {})
  default_tags = lookup(local.meta, "default_tags", {})
  all_tags     = lookup(local.meta, "all_tags", merge(local.default_tags, local.tags))
  flags        = lookup(local.meta, "flags", [])
  iam_path     = lookup(local.meta, "iam_path", null)
  env          = lookup(local.meta, "env", null)
  random       = lookup(local.meta, "random", null)
}
output "meta" {
  value = local.meta
}
