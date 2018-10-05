# Example AWS DynamoDB Table Creation

Configuration in this directory creates an example AWS DynamoDB table.

This example is designed to be used in the [cloud-platform-environments](https://github.com/ministryofjustice/cloud-platform-environments/) repository.

The output will be in a kubernetes `Secret`, which includes the values of `table_name`, `table_arn`, `access_key_id` and `secret_access_key`.

## Usage

In your namespace's path in the [cloud-platform-environments](https://github.com/ministryofjustice/cloud-platform-environments/) repository, create a directory called `resources` (if you have not created one already) and refer to the contents of [main.tf](main.tf) to define the module properties. Make sure to change placeholder values to what is appropriate and refer to the top-level README file in this repository for extra variables that you can use to further customise your resource.

Commit your changes to a branch and raise a pull request. Once approved, you can merge and the changes will be applied. Shortly after, you should be able to access the `Secret` on kubernetes and acccess the resources. You might want to refer to the [documentation on Secrets](https://kubernetes.io/docs/concepts/configuration/secret/).

## Autoscaling

Test autoscaling with a loop like
```
$ while true ; do aws dynamodb put-item --table-name exampleapp-development --item '{"example-hash": {"S": "one"}, "example-range": {"S": "'$RANDOM'"}}' ; done
```
until you get an exception like
```
An error occurred (ProvisionedThroughputExceededException) when calling the PutItem operation (reached max retries: 9): The level of configured provisioned throughput for the table was exceeded. Consider increasing your provisioning level with the UpdateTable API.
```
at this point the db has scaled:
```
$ aws dynamodb describe-table --table-name exampleapp-development | jq -r '.Table | .TableName, (.ProvisionedThroughput | "write:", .WriteCapacityUnits, "read:", .ReadCapacityUnits)' | paste -sd\   -
exampleapp-development write: 3 read: 1
```

Test record expiration with
```
$ aws dynamodb describe-time-to-live --table-name exampleapp-development
$ aws dynamodb put-item --table-name exampleapp-development --item '{"example-hash": {"S": "this-will-vanish"}, "example-range": {"S": "'$RANDOM'"}, "Expires": {"N": "'`date -v+5m +%s`'"}}'
```
Default TTL field name is 'Expires'. Do note that "DynamoDB typically deletes expired items within 48 hours of expiration": https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/howitworks-ttl.html

Run `terraform destroy` when you want to destroy these resources created.
