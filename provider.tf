terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.15.0"
}

provider "google" {
  credentials ="${file("sacred-attic-388300-456cb1e69904.json")}"
  project = var.project_id
  region  = var.region
}
