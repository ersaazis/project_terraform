terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-ersaazis-us-west-2"
    key            = "env/mirror/us-west-2/peering/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "control" {
  backend = "s3"
  config = {
    bucket = "terraform-state-ersaazis-us-west-2"
    key    = "env/production/us-west-2/control/terraform.tfstate"
    region = "us-west-2"
  }
}

data "terraform_remote_state" "application" {
  backend = "s3"
  config = {
    bucket = "terraform-state-ersaazis-us-west-2"
    key    = "env/mirror/us-west-2/application/terraform.tfstate"
    region = "us-west-2"
  }
}

data "terraform_remote_state" "database" {
  backend = "s3"
  config = {
    bucket = "terraform-state-ersaazis-us-west-2"
    key    = "env/mirror/us-west-2/database/terraform.tfstate"
    region = "us-west-2"
  }
}
