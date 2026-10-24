terraform {
  required_version = ">= 1.10" # backend.tf uses use_lockfile, added in 1.10
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 6.70" }
  }
}

# LocalStack: all AWS APIs on one endpoint, fake credentials.
# For a real account remove the endpoints block and the skip_* flags.
provider "aws" {
  region                      = "eu-central-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3             = var.endpoint
    ec2            = var.endpoint
    iam            = var.endpoint
    sts            = var.endpoint
    dynamodb       = var.endpoint
    kms            = var.endpoint
    secretsmanager = var.endpoint
  }
}
