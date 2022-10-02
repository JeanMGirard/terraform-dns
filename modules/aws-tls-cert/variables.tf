# This is where you put your variables declaration


variable "zone_name" {
  type    = string
  default = null
}
variable "zone_id" {
  type    = string
  default = null
}
variable "alt_names" {
  type    = list(string)
  default = []
}


