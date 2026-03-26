provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Environment = "mirror/us-west-2"
      VPC         = "application"
      ManagedBy   = "Terraform"
    }
  }
}
