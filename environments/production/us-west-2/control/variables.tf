variable "admin_cidr" {
  description = "CIDR block allowed to SSH into the control node"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the control node"
  type        = string
}
