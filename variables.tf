variable "enabled" {
  type    = bool
  default = true
}

variable "create_parent_zone_record" {
  type    = bool
  default = false
}
variable "resource_group_id" {
  type    = string
  default = null
}
variable "resource_group_name" {
  type    = string
  default = null
}
variable "parent_zone_id" {
  type        = string
  default     = null
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}
variable "parent_zone_name" {
  type        = string
  default     = null
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}
variable "parent_zone_provider" {
  type        = string
  default     = null
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}
variable "dns_provider" {
  type    = string
  default = "aws"

  validation {
    condition     = contains(["aws", "azure", "gcp"], lower(var.dns_provider))
    error_message = "Allowed DNS providers are: `aws`, `azure` and `gcp`."
  }
}
variable "zone_alias" {
  type    = string
  default = null
}
variable "zone_id" {
  type    = string
  default = null
}
variable "zone_name" {
  type    = string
  default = null
}
variable "alt_names" {
  type    = list(string)
  default = []
}


variable "generate_cert" {
  type    = bool
  default = false
}


variable "create_zone" {
  type    = bool
  default = true
}
variable "is_private" {
  type    = bool
  default = false
}




variable "records" {
  type = any
  #  type = map(object({
  #    name            = optional(string)
  #    enabled         = optional(bool)
  #    type            = optional(string) # A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
  #    ttl             = optional(number)
  #    allow_overwrite = optional(bool)
  #    records         = optional(list(any))
  #    resource_id     = optional(string)
  #  }))
  default     = {}
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`)"
  validation {
    condition = alltrue([for record in values(var.records) : (can(lookup(record, "type", null))
      ? contains(["A", "AAAA", "CAA", "CNAME", "DS", "MX", "NAPTR", "NS", "PTR", "SOA", "SPF", "SRV", "TXT"], lookup(record, "type", "CNAME"))
      : true
    )])
    error_message = "Invalid record type found, allowed values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT."
  }
}



