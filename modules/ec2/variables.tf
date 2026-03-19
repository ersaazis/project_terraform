variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "icmp_allowed_cidr" {
  description = "CIDR block allowed for ICMP"
  type        = string
  default     = "10.0.0.0/8"
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed for SSH"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the instance will be deployed"
  type        = string
}

variable "mysql_allowed_cidrs" {
  description = "List of CIDR blocks allowed for MySQL (3306)"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
