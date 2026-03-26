provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = "global"
      Service     = "IAM"
    }
  }
}
