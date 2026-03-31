resource "aws_security_group" "this" {
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.ssh_allowed_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "icmp_rules" {
  for_each          = toset(var.icmp_allowed_cidrs)
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "mysql" {
  for_each          = toset(var.mysql_allowed_cidrs)
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  for_each          = toset(var.http_allowed_cidrs)
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  for_each          = toset(var.https_allowed_cidrs)
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

################################################################################
# Serial Console & IAM
################################################################################

resource "aws_ec2_serial_console_access" "this" {
  count   = var.enable_serial_console_access ? 1 : 0
  enabled = true
}

resource "random_password" "serial_console" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids      = [aws_security_group.this.id]
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  user_data_replace_on_change = true
  key_name                    = var.key_name

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }

  user_data = <<-EOT
    #!/bin/bash
    echo "${var.os_user}:${random_password.serial_console.result}" | chpasswd
  EOT

  tags = {
    Name = var.instance_name
  }
}
