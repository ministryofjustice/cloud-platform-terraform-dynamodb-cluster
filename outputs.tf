output "table_name" {
  value       = aws_dynamodb_table.default.name
  description = "DynamoDB table name"
}

output "table_arn" {
  value       = aws_dynamodb_table.default.arn
  description = "DynamoDB table ARN"
}

output "access_key_id" {
  description = "Access key id for db"
  value       = aws_iam_access_key.key_2023.id
}

output "secret_access_key" {
  description = "Secret key for db"
  value       = aws_iam_access_key.key_2023.secret
}

