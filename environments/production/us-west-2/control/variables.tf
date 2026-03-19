variable "admin_cidr" {
  description = "CIDR block allowed to SSH into the control node"
  type        = string
  default     = "206.189.42.196/32"
}

variable "ami_id" {
  description = "AMI ID for the control node"
  type        = string
  default     = "ami-0ba80f8099420ac44"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "ersaazis-key"
}
