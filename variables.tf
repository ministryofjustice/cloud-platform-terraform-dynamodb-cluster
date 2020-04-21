variable "team_name" {
}

variable "application" {
}

variable "environment-name" {
}

variable "is-production" {
  default = "false"
}

variable "business-unit" {
  description = " Area of the MOJ responsible for the service"
  default     = "mojdigital"
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>)"
}

variable "hash_key" {
}

variable "hash_key_type" {
  default = "S"
}

variable "range_key" {
}

variable "range_key_type" {
  default = "S"
}

variable "attributes" {
  type = list(object({
    name = string
    type = string
  }))
  default     = []
  description = "Additional DynamoDB attributes in the form of a list of mapped values"
}

variable "enable_encryption" {
  type        = string
  default     = "true"
  description = "Enable DynamoDB server-side encryption"
}

variable "ttl_attribute" {
  type        = string
  default     = "Expires"
  description = "DynamoDB table TTL attribute"
}

variable "autoscale_write_target" {
  default     = 50
  description = "The target value (in %) for DynamoDB write autoscaling"
}

variable "autoscale_read_target" {
  default     = 50
  description = "The target value (in %) for DynamoDB read autoscaling"
}

variable "autoscale_min_read_capacity" {
  default     = 1
  description = "DynamoDB autoscaling min read capacity"
}

variable "autoscale_max_read_capacity" {
  default     = 10
  description = "DynamoDB autoscaling max read capacity"
}

variable "autoscale_min_write_capacity" {
  default     = 1
  description = "DynamoDB autoscaling min write capacity"
}

variable "autoscale_max_write_capacity" {
  default     = 10
  description = "DynamoDB autoscaling max write capacity"
}

variable "enable_autoscaler" {
  type        = string
  default     = "true"
  description = "Flag to enable/disable DynamoDB autoscaling"
}

variable "aws_region" {
  description = "Region into which the resource will be created"
  default     = "eu-west-2"
}

