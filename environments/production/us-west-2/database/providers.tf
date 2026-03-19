provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Environment = "us-west-2"
      VPC         = "database"
      ManagedBy   = "Terraform"
    }
  }
}
