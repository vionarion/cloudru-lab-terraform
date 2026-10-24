# State lives in a self-hosted S3 (RustFS, see docker-apps/apps/rustfs) with a native lock file.
# Connection settings are kept out of git: copy backend.hcl.example to backend.hcl, then
#   terraform init -backend-config=backend.hcl
# Credentials come from AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY.
terraform {
  backend "s3" {}
}
