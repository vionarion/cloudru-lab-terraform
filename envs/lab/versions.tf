terraform {
  required_version = ">= 1.10"
  required_providers {
    cloudru = {
      source  = "cloudru/cloud"
      version = "2.1.5"
    }
  }
}

# Credentials come from AUTH_KEY_ID / AUTH_SECRET environment variables.
provider "cloudru" {
  project_id = var.project_id
}
