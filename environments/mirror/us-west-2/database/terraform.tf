terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    key = "env/mirror/us-west-2/database/terraform.tfstate"
  }
}

locals {
  backend_config = {
    for line in split("\n", file("${path.module}/../../../../terraform.tfbackend")) :
    trimspace(split("=", line)[0]) => trim(trimspace(split("=", line)[1]), "\"")
    if length(split("=", line)) == 2
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = local.backend_config["bucket"]
    region = local.backend_config["region"]
    key    = "global/iam/terraform.tfstate"
  }
}

# Removed circular dependency on application state for bootstrapping
