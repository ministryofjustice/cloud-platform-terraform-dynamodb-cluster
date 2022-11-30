variable "team_name" {
  type        = string
  description = "Team name"
}

variable "application" {
  type        = string
  description = "Application name"
}

variable "environment-name" {
  type        = string
  description = "Environment name"
}

variable "is-production" {
  default     = "false"
  type        = string
  description = "Whether namespace is production or not"
}

variable "business-unit" {
  description = " Area of the MOJ responsible for the service"
  default     = "mojdigital"
  type        = string
}

variable "namespace" {
  type        = string
  description = "Namespace name"
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>)"
  type        = string
}

variable "hash_key" {
  type        = string
  description = "Hash key name"
}

variable "hash_key_type" {
  default     = "S"
  type        = string
  description = "Hash key type"
}

variable "range_key" {
  default     = ""
  type        = string
  description = "Range key name"
}

variable "range_key_type" {
  default     = "S"
  type        = string
  description = "Hash key type"
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
  type        = number
}

variable "autoscale_read_target" {
  default     = 50
  description = "The target value (in %) for DynamoDB read autoscaling"
  type        = number
}

variable "autoscale_min_read_capacity" {
  default     = 1
  description = "DynamoDB autoscaling min read capacity"
  type        = number
}

variable "autoscale_max_read_capacity" {
  default     = 10
  description = "DynamoDB autoscaling max read capacity"
  type        = number
}

variable "autoscale_min_write_capacity" {
  default     = 1
  description = "DynamoDB autoscaling min write capacity"
  type        = number
}

variable "autoscale_max_write_capacity" {
  default     = 10
  description = "DynamoDB autoscaling max write capacity"
  type        = number
}

variable "enable_autoscaler" {
  type        = string
  default     = "true"
  description = "Flag to enable/disable DynamoDB autoscaling"
}

variable "aws_region" {
  description = "Region into which the resource will be created"
  default     = "eu-west-2"
  type        = string
}

variable "global_secondary_indexes" {
  description = "A list of maps of GSIs for the DynamoDB table"
  default     = []
  type        = list(any)
}

variable "billing_mode" {
  description = "Billing mode (PAY_PER_REQUEST or PROVISIONED) for the DynamoDB table"
  default     = "PROVISIONED"
  type        = string
}
