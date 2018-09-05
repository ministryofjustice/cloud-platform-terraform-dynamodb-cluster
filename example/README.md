# example AWS DynamoDB Instance Creation

Configuration in this directory creates an example AWS DynamodB Instance


This example outputs user name and secrets for the new credentials.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Test autoscaling with a loop like
```
$ while true ; do AWS_PROFILE=ddb aws dynamodb put-item --table-name exampleapp-development --item '{"example-hash": {"S": "one"}, "example-range": {"S": "'$RANDOM'"}}' ; done
```
until you get an exception like
```
An error occurred (ProvisionedThroughputExceededException) when calling the PutItem operation (reached max retries: 9): The level of configured provisioned throughput for the table was exceeded. Consider increasing your provisioning level with the UpdateTable API.
```
at this point the table has scaled:
```AWS_PROFILE=ddb aws dynamodb describe-table --table-name exampleapp-development | jq -r '.Table | .TableName, (.ProvisionedThroughput | "write:", .WriteCapacityUnits, "read:", .ReadCapacityUnits)' | paste -sd\   -
exampleapp-development write: 3 read: 1
```

Run `terraform destroy` when you want to destroy these resources created.
