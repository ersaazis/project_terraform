variable "ami_id" {
  description = "AMI ID for the database node"
  type        = string
  default     = "ami-0ba80f8099420ac44"
}


variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "secret-key-mirror-db-us-west-2"
}
