output "table_name" {
  value       = "${aws_dynamodb_table.table.name}"
  description = "DynamoDB table name"
}

output "table_id" {
  value       = "${aws_dynamodb_table.table.id}"
  description = "DynamoDB table ID"
}

output "table_arn" {
  value       = "${aws_dynamodb_table.table.arn}"
  description = "DynamoDB table ARN"
}

output "access_key_id" {
  description = "Access key id for db"
  value       = "${aws_iam_access_key.user.id}"
}

output "secret_access_key" {
  description = "Secret key for db"
  value       = "${aws_iam_access_key.user.secret}"
}
