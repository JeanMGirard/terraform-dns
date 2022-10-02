variable "zone_alias" {
  type    = string
  default = ""
}
variable "zone_name" {
  type        = string
  default     = "$${name}.$${stage}.$${parent_zone_name}"
  description = "Zone name"
}
variable "zone_id" {
  type        = string
  default     = null
  description = "Zone id. Do not create the zone if specified"
}
variable "parent_zone_id" {
  type        = string
  default     = null
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}
variable "parent_zone_name" {
  type        = string
  default     = null
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`)"
}
variable "parent_zone_record_enabled" {
  type        = bool
  default     = null
  description = "Whether to create the NS record on the parent zone. Useful for creating a cluster zone across accounts. `var.parent_zone_name` required if set to false."
}
variable "generate_cert" {
  type    = bool
  default = false
}
variable "alt_names" {
  type    = list(string)
  default = []
}
variable "records" {
  type = map(object({
    name            = string
    type            = string # A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
    ttl             = string
    allow_overwrite = bool
    records         = list(string)
  }))
  default     = {}
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`)"
}
