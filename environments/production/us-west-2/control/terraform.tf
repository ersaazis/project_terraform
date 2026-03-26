terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    key = "env/production/us-west-2/control/terraform.tfstate"
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

data "terraform_remote_state" "application" {
  backend = "s3"
  config = {
    bucket = local.backend_config["bucket"]
    region = local.backend_config["region"]
    key    = "env/production/us-west-2/application/terraform.tfstate"
  }
}

data "terraform_remote_state" "internal" {
  for_each = {
    "prod-db" = "env/production/us-west-2/database/terraform.tfstate"
    "dev-app" = "env/development/us-west-2/application/terraform.tfstate"
    "dev-db"  = "env/development/us-west-2/database/terraform.tfstate"
    "sta-app" = "env/staging/us-west-2/application/terraform.tfstate"
    "sta-db"  = "env/staging/us-west-2/database/terraform.tfstate"
    "mir-app" = "env/mirror/us-west-2/application/terraform.tfstate"
    "mir-db"  = "env/mirror/us-west-2/database/terraform.tfstate"
  }

  backend = "s3"
  config = {
    bucket = local.backend_config["bucket"]
    region = local.backend_config["region"]
    key    = each.value
  }
}
