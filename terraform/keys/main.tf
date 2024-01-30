terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = "/workspaces/HauwaZoomcamp2024/terraform/keys/my-creds.json"
  project     = "just-program-411315"
  region      = "us-central1"
}

#here we are defining the resource and stating the type of resource we would like to create
resource "google_storage_bucket" "demo-bucket" {
  name          = "just-program-411315-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}