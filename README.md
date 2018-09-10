# cloud-platform-terraform-dynamodb-cluster

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
  source    = "github.com/ministryofjustice/cloud-platform-terraform-dynamodb-cluster?ref=v1.0"
  team_name = "example-team"

  hash_key  = "example-hash"
  range_key = "example-range"
}
```

Sample usage is shown in the aptly named [example](example) folder.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| team_name | name of the team | string | - | yes |
| application | as per [the technical guidance](https://ministryofjustice.github.io/technical-guidance/standards/documenting-infrastructure-owners/#tagging-your-infrastructure)  | string | - | yes |
| environment | dev,prod | string | - | yes |
| hash_key |  unique identifier | string | - | yes |
| range_key | aka sort attribute | string | - | yes |
| autoscale_write_target | 50% throttled reqs | n | 50 | no |
| autoscale_read_target | 50% throttled reqs | n | 50 | no |
| autoscale_min_read_capacity | AWS-specific "units" | n | 1 | no |
| autoscale_min_write_capacity | AWS-specific "units" | n | 1 | no |
| autoscale_max_read_capacity | AWS-specific "units" | n | 10 | no |
| autoscale_max_write_capacity | AWS-specific "units" | n | 10 | no |
| enable_autoscaler | on/off | bool | true | no |

## Outputs

| Name | Description |
|------|-------------|
| access_key_id | Access key id for the new user |
| secret_access_key | Secret for the new user |
| table_arn | AWS DynamoDB ARN |
| table_name | Table name |
