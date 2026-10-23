terraform {
  required_version = ">= 1.10"
  required_providers {
    cloudru = {
      source  = "cloudru/cloud"
      version = "~> 2.1"
    }
  }
}
