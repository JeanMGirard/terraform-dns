/* 
  *****************************************************
    This file was generated!
    Edit at your own risks,you could loose your changes
  *****************************************************
*/

variable "enabled" { default = true }
variable "name" { default = null }
variable "description" { default = null }
variable "stage" { default = null }
variable "tags" { default = null }
variable "attributes" { default = null }
variable "flags" { default = null }
variable "iam_path" { default = null }
variable "random" { default = null }
variable "region" { default = null }
variable "account" { default = null }
variable "environment" { default = null }


variable "meta" {
  type = any
  default = {
    # Identifiers
    tenant    = null
    stack     = null
    namespace = null
    project   = null
    module    = null
    # Deployment
    environment = null
    region      = null
    stage       = null
    # Description
    name        = null
    description = null
    # Configs
    enabled      = null
    iam_path     = null
    attributes   = {}
    default_tags = {}
    tags         = {}
    flags        = []
  }
}

module "meta" {
  source = "git@github.com:JeanMGirard/terraform-meta.git"
  meta   = var.meta

  enabled     = var.enabled
  name        = var.name
  description = var.description
  stage       = var.stage
  tags        = var.tags
  attributes  = var.attributes
  flags       = var.flags
  iam_path    = var.iam_path
}
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
