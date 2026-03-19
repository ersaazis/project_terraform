variable "lock_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket for state storage"
  type        = string
}
