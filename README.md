# cloud-platform-terraform-dynamodb-cluster

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-dynamodb-cluster/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-dynamodb-cluster/releases)

DynamoDB instance and credentials for the Cloud Platform.
This module will create a "simple" (as opposed to a "global") table, with some safe defaults:
 - a dedicated IAM user and API key allowing only access to this resource
 - point-in-time recovery (35 days of automatic incremental backups)
 - server-side encryption
 - time-to-live enabled
 - automatic autoscaling for both read&write units (default 1-10)

## Usage

```hcl
module "example_team_dynamodb" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-dynamodb-cluster?ref=version"

  team_name              = var.team_name
  business-unit          = var.business_unit
  application            = var.application
  is-production          = var.is_production
  environment-name       = var.environment
  infrastructure-support = var.infrastructure_support
  aws_region             = "eu-west-2"
  namespace              = var.namespace

  hash_key  = "example-hash"
  range_key = "example-range"
}
```

Sample usage is shown in the aptly named [example](example) folder.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.27.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.27.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb_autoscaler"></a> [dynamodb\_autoscaler](#module\_dynamodb\_autoscaler) | cloudposse/dynamodb-autoscaler/aws | 0.14.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_access_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.autoscaler_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.userpol](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.autoscaler_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application name | `string` | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional DynamoDB attributes in the form of a list of mapped values | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| <a name="input_autoscale_max_read_capacity"></a> [autoscale\_max\_read\_capacity](#input\_autoscale\_max\_read\_capacity) | DynamoDB autoscaling max read capacity | `number` | `10` | no |
| <a name="input_autoscale_max_write_capacity"></a> [autoscale\_max\_write\_capacity](#input\_autoscale\_max\_write\_capacity) | DynamoDB autoscaling max write capacity | `number` | `10` | no |
| <a name="input_autoscale_min_read_capacity"></a> [autoscale\_min\_read\_capacity](#input\_autoscale\_min\_read\_capacity) | DynamoDB autoscaling min read capacity | `number` | `1` | no |
| <a name="input_autoscale_min_write_capacity"></a> [autoscale\_min\_write\_capacity](#input\_autoscale\_min\_write\_capacity) | DynamoDB autoscaling min write capacity | `number` | `1` | no |
| <a name="input_autoscale_read_target"></a> [autoscale\_read\_target](#input\_autoscale\_read\_target) | The target value (in %) for DynamoDB read autoscaling | `number` | `50` | no |
| <a name="input_autoscale_write_target"></a> [autoscale\_write\_target](#input\_autoscale\_write\_target) | The target value (in %) for DynamoDB write autoscaling | `number` | `50` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | Billing mode (PAY\_PER\_REQUEST or PROVISIONED) for the DynamoDB table | `string` | `"PROVISIONED"` | no |
| <a name="input_business-unit"></a> [business-unit](#input\_business-unit) | Area of the MOJ responsible for the service | `string` | n/a | yes |
| <a name="input_enable_autoscaler"></a> [enable\_autoscaler](#input\_enable\_autoscaler) | Flag to enable/disable DynamoDB autoscaling | `string` | `"true"` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | Enable DynamoDB server-side encryption | `string` | `"true"` | no |
| <a name="input_environment-name"></a> [environment-name](#input\_environment-name) | Environment name | `string` | n/a | yes |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | A list of maps of GSIs for the DynamoDB table | `list(any)` | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | Hash key name | `string` | n/a | yes |
| <a name="input_hash_key_type"></a> [hash\_key\_type](#input\_hash\_key\_type) | Hash key type | `string` | `"S"` | no |
| <a name="input_infrastructure-support"></a> [infrastructure-support](#input\_infrastructure-support) | The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>) | `string` | n/a | yes |
| <a name="input_is-production"></a> [is-production](#input\_is-production) | Whether namespace is production or not | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name | `string` | n/a | yes |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | Range key name | `string` | `""` | no |
| <a name="input_range_key_type"></a> [range\_key\_type](#input\_range\_key\_type) | Hash key type | `string` | `"S"` | no |
| <a name="input_team_name"></a> [team\_name](#input\_team\_name) | Team name | `string` | n/a | yes |
| <a name="input_ttl_attribute"></a> [ttl\_attribute](#input\_ttl\_attribute) | DynamoDB table TTL attribute | `string` | `"Expires"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | Access key id for db |
| <a name="output_irsa_policy_arn"></a> [irsa\_policy\_arn](#output\_irsa\_policy\_arn) | n/a |
| <a name="output_secret_access_key"></a> [secret\_access\_key](#output\_secret\_access\_key) | Secret key for db |
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | DynamoDB table ARN |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | DynamoDB table name |
<!-- END_TF_DOCS -->
