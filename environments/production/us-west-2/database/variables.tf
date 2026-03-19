variable "ami_id" {
  description = "AMI ID for the database node"
  type        = string
  default     = "ami-0ba80f8099420ac44"
}

variable "control_vpc_cidr" {
  description = "CIDR block of the control VPC allowed to SSH"
  type        = string
  default     = "10.11.0.0/16"
}

variable "app_vpc_cidr" {
  description = "CIDR block of the application VPC allowed to access MySQL"
  type        = string
  default     = "10.12.0.0/16"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "ersaazis-key"
}
