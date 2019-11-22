provider "aws" {
  alias  = "custom"
  region = var.aws_region
}

data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

resource "random_id" "id" {
  byte_length = 8
}

resource "aws_dynamodb_table" "default" {
  provider       = aws.custom
  name           = "cp-${random_id.id.hex}"
  read_capacity  = var.autoscale_min_read_capacity
  write_capacity = var.autoscale_min_write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  attribute {
    name = var.range_key
    type = var.range_key_type
  }

  server_side_encryption {
    enabled = var.enable_encryption
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity,
    ]
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = "true"
  }

  point_in_time_recovery {
    enabled = "true"
  }

  tags = {
    business-unit          = var.business-unit
    application            = var.application
    is-production          = var.is-production
    environment-name       = var.environment-name
    owner                  = var.team_name
    infrastructure-support = var.infrastructure-support
  }
}

module "dynamodb_autoscaler" {
  source = "git::https://github.com/ministryofjustice/cloud-platform-terraform-dynamodb-autoscaler.git?ref=tags/0.2.6-cp"

  enabled                      = var.enable_autoscaler
  name                         = "cp-dynamo-${random_id.id.hex}"
  dynamodb_table_name          = aws_dynamodb_table.default.id
  dynamodb_table_arn           = aws_dynamodb_table.default.arn
  autoscale_write_target       = var.autoscale_write_target
  autoscale_read_target        = var.autoscale_read_target
  autoscale_min_read_capacity  = var.autoscale_min_read_capacity
  autoscale_max_read_capacity  = var.autoscale_max_read_capacity
  autoscale_min_write_capacity = var.autoscale_min_write_capacity
  autoscale_max_write_capacity = var.autoscale_max_write_capacity
  aws_region                   = var.aws_region
}

resource "aws_iam_user" "user" {
  name = "cp-dynamo-${random_id.id.hex}"
  path = "/system/dynamo-user/${var.team_name}/"
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "userpol" {
  name   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.policy.json
  user   = aws_iam_user.user.name
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "dynamodb:*",
    ]

    resources = [
      aws_dynamodb_table.default.arn,
    ]
  }
}

