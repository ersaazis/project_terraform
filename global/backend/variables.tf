variable "lock_table_prefix" {
  description = "Prefix for the DynamoDB table for state locking"
  type        = string
  default     = "terraform-locks"
}

variable "state_bucket_prefix" {
  description = "Prefix for the S3 bucket for state storage"
  type        = string
  default     = "terraform-state"
}
