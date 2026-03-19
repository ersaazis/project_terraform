variable "ami_id" {
  description = "AMI ID for the application node"
  type        = string
}

variable "control_vpc_cidr" {
  description = "CIDR block of the control VPC allowed to SSH"
  type        = string
  default     = "10.11.0.0/16"
}
