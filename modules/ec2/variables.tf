variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "icmp_allowed_cidrs" {
  description = "CIDR blocks allowed to send ICMP traffic (ping)"
  type        = list(string)
  default     = []
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

variable "http_allowed_cidrs" {
  description = "List of CIDR blocks allowed for HTTP (80)"
  type        = list(string)
  default     = []
}

variable "https_allowed_cidrs" {
  description = "List of CIDR blocks allowed for HTTPS (443)"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = null
}

variable "enable_serial_console_access" {
  description = "Whether to enable EC2 Serial Console access for the account in the current region"
  type        = bool
  default     = false
}

variable "os_user" {
  description = "The default OS user to set the password for (e.g., ec2-user, ubuntu, admin)"
  type        = string
  default     = "ec2-user"
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile to associate with the instance"
  type        = string
  default     = null
}
