# Bucket for Terraform remote state: versioning, KMS encryption, no public access.
# Locking: S3 native lockfile (use_lockfile = true, Terraform >= 1.10), DynamoDB no longer needed.
resource "aws_kms_key" "state" {
  description         = "terraform state"
  enable_key_rotation = true
}

resource "aws_s3_bucket" "state" {
  bucket = "lab-terraform-state"
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.state.arn
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
