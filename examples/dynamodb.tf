/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */
module "example_team_dynamodb" {
  source = "../"

  team_name              = var.team_name
  business_unit          = var.business_unit
  application            = var.application
  is_production          = var.is_production
  environment_name       = var.environment_name
  infrastructure_support = var.infrastructure_support
  namespace              = var.namespace

  hash_key  = "example-hash"
  range_key = "example-range"
  attributes = [
    {
      name = "UserId"
      type = "S"
    },
    {
      name = "GameTitle"
      type = "S"
    },
    {
      name = "TopScore"
      type = "N"
    }
  ]
}

resource "kubernetes_secret" "example_team_dynamodb" {
  metadata {
    name      = "example-team-dynamodb-output"
    namespace = "my-namespace"
  }

  data = {
    table_name = module.example_team_dynamodb.table_name
    table_arn  = module.example_team_dynamodb.table_arn
  }
}
