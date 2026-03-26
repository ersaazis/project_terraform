provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Service     = "Keys"
      Environment = "global"
    }
  }
}
