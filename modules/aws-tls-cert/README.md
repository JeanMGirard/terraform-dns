# Terraform modules - AWS DNS Certificate

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1   |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 3.1   |
| <a name="requirement_random"></a> [random](#requirement\_random)          | >= 3.1.0 |

## Providers

| Name                                              | Version |
|---------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.1  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                 | Type        |
|------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                              | resource    |
| [aws_acm_certificate_validation.validations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource    |
| [aws_route53_record.dns_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                      | resource    |
| [aws_route53_zone.zone_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                              | data source |
| [aws_route53_zone.zone_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                            | data source |

## Inputs

| Name                                                            | Description | Type           | Default | Required |
|-----------------------------------------------------------------|-------------|----------------|---------|:--------:|
| <a name="input_alt_names"></a> [alt\_names](#input\_alt\_names) | n/a         | `list(string)` | `[]`    |    no    |
| <a name="input_meta"></a> [meta](#input\_meta)                  | n/a         | `any`          | `{}`    |    no    |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id)       | n/a         | `string`       | `null`  |    no    |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | n/a         | `string`       | `null`  |    no    |

## Outputs

| Name                                                               | Description |
|--------------------------------------------------------------------|-------------|
| <a name="output_meta"></a> [meta](#output\_meta)                   | n/a         |
| <a name="output_result"></a> [result](#output\_result)             | n/a         |
| <a name="output_validation"></a> [validation](#output\_validation) | n/a         |

<!-- END_TF_DOCS -->
