terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

locals {
  key_defs = {
    "prod-control" = { env = "production", comp = "control", loc = "us-west-2" }
    "prod-app"     = { env = "production", comp = "application", loc = "us-west-2" }
    "prod-db"      = { env = "production", comp = "database", loc = "us-west-2" }
    "staging-app"  = { env = "staging", comp = "application", loc = "us-west-2" }
    "staging-db"   = { env = "staging", comp = "database", loc = "us-west-2" }
    "dev-app"      = { env = "development", comp = "application", loc = "us-west-2" }
    "dev-db"       = { env = "development", comp = "database", loc = "us-west-2" }
    "mirror-app"   = { env = "mirror", comp = "application", loc = "us-west-2" }
    "mirror-db"    = { env = "mirror", comp = "database", loc = "us-west-2" }
  }
}

resource "tls_private_key" "this" {
  for_each  = locals.key_defs
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  for_each   = locals.key_defs
  key_name   = "secret-key-${each.key}-${each.value.loc}"
  public_key = tls_private_key.this[each.key].public_key_openssh

  tags = {
    Name      = "secret-key-${each.key}-${each.value.loc}"
    ManagedBy = "Terraform"
    Env       = each.value.env
    Component = each.value.comp
  }
}

resource "local_file" "private_key" {
  for_each        = locals.key_defs
  content         = tls_private_key.this[each.key].private_key_pem
  filename        = "${pathexpand("~/.ssh")}/secret-key-${each.key}-${each.value.loc}.pem"
  file_permission = "0400"
}
