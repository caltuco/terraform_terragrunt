generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
      }
    }
  }
provider "aws" {
  region = "us-east-1"
  profile = "caltuco_aws"
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terragrunt-tfstate-caltuco"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region                  = "us-east-1"
    profile                 = "caltuco_aws"
    encrypt                 = true
    dynamodb_table          = "terraform-state-lock"
  }
}
