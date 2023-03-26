# Terraform modules - DNS Zone

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws"></a> [aws](#module\_aws) | ./modules/aws-dns | n/a |
| <a name="module_azure"></a> [azure](#module\_azure) | ./modules/azure-dns | n/a |
| <a name="module_meta"></a> [meta](#module\_meta) | git@github.com:JeanMGirard/terraform-meta.git | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_ns_record.parent_az](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_zone.parent_az](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alt_names"></a> [alt\_names](#input\_alt\_names) | n/a | `list(string)` | `[]` | no |
| <a name="input_create_parent_zone_record"></a> [create\_parent\_zone\_record](#input\_create\_parent\_zone\_record) | n/a | `bool` | `false` | no |
| <a name="input_create_zone"></a> [create\_zone](#input\_create\_zone) | n/a | `bool` | `true` | no |
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | Cloud provider for the zone. | `string` | `"aws"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_generate_cert"></a> [generate\_cert](#input\_generate\_cert) | =============================================================================================== ===== Behavior =============================================================================================== | `bool` | `false` | no |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private) | n/a | `bool` | `false` | no |
| <a name="input_meta"></a> [meta](#input\_meta) | n/a | `any` | `{}` | no |
| <a name="input_parent_zone_id"></a> [parent\_zone\_id](#input\_parent\_zone\_id) | ID of the hosted zone to contain this record  (or specify `parent_zone_name`) | `string` | `null` | no |
| <a name="input_parent_zone_name"></a> [parent\_zone\_name](#input\_parent\_zone\_name) | ID of the hosted zone to contain this record  (or specify `parent_zone_name`) | `string` | `null` | no |
| <a name="input_parent_zone_provider"></a> [parent\_zone\_provider](#input\_parent\_zone\_provider) | ID of the hosted zone to contain this record  (or specify `parent_zone_name`) | `string` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | Name of the hosted zone to contain this record (or specify `parent_zone_id`) | `any` | `{}` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | n/a | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_zone_alias"></a> [zone\_alias](#input\_zone\_alias) | n/a | `string` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_provider"></a> [dns\_provider](#output\_dns\_provider) | n/a |
| <a name="output_meta"></a> [meta](#output\_meta) | n/a |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | n/a |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | n/a |
<!-- END_TF_DOCS -->
