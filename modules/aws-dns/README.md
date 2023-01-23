<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3   |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 3.1   |
| <a name="requirement_random"></a> [random](#requirement\_random)          | >= 3.1.0 |

## Providers

| Name                                              | Version |
|---------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.1  |

## Modules

| Name                                             | Source          | Version |
|--------------------------------------------------|-----------------|---------|
| <a name="module_cert"></a> [cert](#module\_cert) | ../aws-tls-cert | n/a     |

## Resources

| Name                                                                                                                        | Type        |
|-----------------------------------------------------------------------------------------------------------------------------|-------------|
| [aws_route53_record.ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)         | resource    |
| [aws_route53_record.records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)    | resource    |
| [aws_route53_record.soa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)        | resource    |
| [aws_route53_zone.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone)        | resource    |
| [aws_route53_zone.parent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)      | data source |
| [aws_route53_zone.parent_info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name                                                                                                                | Description                                                                                                                                              | Type           | Default                                  | Required |
|---------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|------------------------------------------|:--------:|
| <a name="input_alt_names"></a> [alt\_names](#input\_alt\_names)                                                     | n/a                                                                                                                                                      | `list(string)` | `[]`                                     |    no    |
| <a name="input_create_parent_zone_record"></a> [create\_parent\_zone\_record](#input\_create\_parent\_zone\_record) | Whether to create the NS record on the parent zone. Useful for creating a cluster zone across accounts. `var.parent_zone_name` required if set to false. | `bool`         | `null`                                   |    no    |
| <a name="input_generate_cert"></a> [generate\_cert](#input\_generate\_cert)                                         | n/a                                                                                                                                                      | `bool`         | `false`                                  |    no    |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private)                                                  | n/a                                                                                                                                                      | `bool`         | `false`                                  |    no    |
| <a name="input_meta"></a> [meta](#input\_meta)                                                                      | n/a                                                                                                                                                      | `any`          | `{}`                                     |    no    |
| <a name="input_parent_zone_id"></a> [parent\_zone\_id](#input\_parent\_zone\_id)                                    | ID of the hosted zone to contain this record  (or specify `parent_zone_name`)                                                                            | `string`       | `null`                                   |    no    |
| <a name="input_parent_zone_name"></a> [parent\_zone\_name](#input\_parent\_zone\_name)                              | Name of the hosted zone to contain this record (or specify `parent_zone_id`)                                                                             | `string`       | `null`                                   |    no    |
| <a name="input_records"></a> [records](#input\_records)                                                             | Name of the hosted zone to contain this record (or specify `parent_zone_id`)                                                                             | `any`          | `{}`                                     |    no    |
| <a name="input_zone_alias"></a> [zone\_alias](#input\_zone\_alias)                                                  | n/a                                                                                                                                                      | `string`       | `""`                                     |    no    |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id)                                                           | Zone id. Do not create the zone if specified                                                                                                             | `string`       | `null`                                   |    no    |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name)                                                     | Zone name                                                                                                                                                | `string`       | `"${name}.${stage}.${parent_zone_name}"` |    no    |

## Outputs

| Name                                                                                        | Description                                    |
|---------------------------------------------------------------------------------------------|------------------------------------------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn)                                            | Fully-qualified domain name                    |
| <a name="output_meta"></a> [meta](#output\_meta)                                            | n/a                                            |
| <a name="output_parent_zone_id"></a> [parent\_zone\_id](#output\_parent\_zone\_id)          | ID of the hosted zone to contain this record   |
| <a name="output_parent_zone_name"></a> [parent\_zone\_name](#output\_parent\_zone\_name)    | Name of the hosted zone to contain this record |
| <a name="output_records"></a> [records](#output\_records)                                   | DNS Records.                                   |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id)                                 | Route53 DNS Zone ID                            |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name)                           | Route53 DNS Zone name                          |
| <a name="output_zone_name_servers"></a> [zone\_name\_servers](#output\_zone\_name\_servers) | Route53 DNS Zone Name Servers                  |

<!-- END_TF_DOCS -->
