# Terraform modules - AWS DNS Zone


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws"></a> [aws](#module\_aws) | ./../../aws/dns-zone | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | n/a | `string` | `"aws"` | no |
| <a name="input_generate_cert"></a> [generate\_cert](#input\_generate\_cert) | n/a | `bool` | `false` | no |
| <a name="input_parent_zone"></a> [parent\_zone](#input\_parent\_zone) | ID of the hosted zone to contain this record  (or specify `parent_zone_name`) | <pre>object({<br>		id         = string<br>		name       = string<br>		add_record = bool<br>    provider   = string<br>	})</pre> | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | Name of the hosted zone to contain this record (or specify `parent_zone_id`) | <pre>map(object({<br>		name            = string<br>		type            = string # A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.<br>		ttl             = string<br>		allow_overwrite = bool<br>		records         = list(string)<br>	}))</pre> | `{}` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | <pre>object({<br>		alias     = string<br>		name      = string<br>		id        = string<br>		alt_names = list(string)<br>	})</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_provider"></a> [dns\_provider](#output\_dns\_provider) | n/a |
| <a name="output_zone"></a> [zone](#output\_zone) | DNS Zone |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | n/a |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | n/a |
<!-- END_TF_DOCS -->
