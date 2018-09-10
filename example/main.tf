provider "aws" {
  region  = "eu-west-1"
  version = ">= 1.17.0"
}

module "example_team_dynamodb" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-dynamodb-cluster?ref=v1.0"

  team_name              = "example-team"
  business-unit          = "example-bu"
  application            = "exampleapp"
  is-production          = "false"
  environment-name       = "development"
  infrastructure-support = "example-team@digtal.justice.gov.uk"

  hash_key  = "example-hash"
  range_key = "example-range"
}
