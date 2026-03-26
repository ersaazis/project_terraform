provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Environment = "production/us-west-2"
      VPC         = "control"
      ManagedBy   = "Terraform"
    }
  }
}
