# Step 2: after the first apply created the bucket, move state into it:
#   terraform init -migrate-state
terraform {
  backend "s3" {
    bucket       = "lab-terraform-state"
    key          = "lab/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true

    access_key                  = "test"
    secret_key                  = "test"
    endpoints                   = { s3 = "http://localhost:4566", sts = "http://localhost:4566" }
    use_path_style              = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
  }
}
