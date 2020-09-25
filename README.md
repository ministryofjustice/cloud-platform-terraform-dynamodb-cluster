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

  team_name              = "example-team"
  business-unit          = "example-bu"
  application            = "exampleapp"
  is-production          = "false"
  environment-name       = "development"
  infrastructure-support = "example-team@digtal.justice.gov.uk"
  aws_region             = "eu-west-2"

  hash_key  = "example-hash"
  range_key = "example-range"
}
```

Sample usage is shown in the aptly named [example](example) folder.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| hash_key |  unique identifier | string | - | yes |
| hash_key_type |  unique identifier | string | "S" | no |
| range_key | aka sort attribute | string | - | yes |
| range_key_type | aka sort attribute | string | "S" | no |
| enable_encryption | on/off | bool | true | no |
| ttl_attribute | field name in DB | string | "Expires" | no |
| autoscale_write_target | 50% throttled reqs | n | 50 | no |
| autoscale_read_target | 50% throttled reqs | n | 50 | no |
| autoscale_min_read_capacity | AWS-specific "units" | n | 1 | no |
| autoscale_min_write_capacity | AWS-specific "units" | n | 1 | no |
| autoscale_max_read_capacity | AWS-specific "units" | n | 10 | no |
| autoscale_max_write_capacity | AWS-specific "units" | n | 10 | no |
| enable_autoscaler | on/off | bool | true | no |
| aws_region | region | string | eu-west-2 | no |
| attributes | attribute definitions  | list(objects) | - | no |


### Tags

Some of the inputs are tags. All infrastructure resources need to be tagged according to the [MOJ technical guidance](https://ministryofjustice.github.io/technical-guidance/documentation/standards/documenting-infrastructure-owners.html#documenting-owners-of-infrastructure). The tags are stored as variables that you will need to fill out as part of your module.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| team_name |  | string | - | yes |
| application |  | string | - | yes |
| business-unit | Area of the MOJ responsible for the service | string | `mojdigital` | yes |
| environment-name |  | string | - | yes |
| infrastructure-support | The team responsible for managing the infrastructure. Should be of the form team-email | string | - | yes |
| is-production |  | string | `false` | yes |

## Outputs

| Name | Description |
|------|-------------|
| access_key_id | Access key id for the new user |
| secret_access_key | Secret for the new user |
| table_arn | AWS DynamoDB ARN |
| table_name | Table name |
