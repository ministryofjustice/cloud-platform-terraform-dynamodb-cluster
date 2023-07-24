output "table_name" {
  value       = aws_dynamodb_table.default.name
  description = "DynamoDB table name"
}

output "table_arn" {
  value       = aws_dynamodb_table.default.arn
  description = "DynamoDB table ARN"
}

output "irsa_policy_arn" {
  description = "IAM policy ARN for access to the DynamoDB table"
  value       = aws_iam_policy.irsa.arn
}
