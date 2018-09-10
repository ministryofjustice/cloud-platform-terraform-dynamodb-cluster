output "table_name" {
  value       = "${module.example_team_dynamodb.table_name}"
  description = "DynamoDB table name"
}

output "table_arn" {
  value       = "${module.example_team_dynamodb.table_arn}"
  description = "DynamoDB table ARN"
}

output "access_key_id" {
  description = "Access key id for db"
  value       = "${module.example_team_dynamodb.access_key_id}"
}

output "secret_access_key" {
  description = "Secret key for db"
  value       = "${module.example_team_dynamodb.secret_access_key}"
}
