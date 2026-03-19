variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "trusted_service" {
  description = "The AWS service that can assume this role (e.g., ec2.amazonaws.com)"
  type        = string
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile for this role"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the IAM resources"
  type        = map(string)
  default     = {}
}
