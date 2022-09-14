provider "google" {
  project = "solid-egress-filter"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

terraform {
  backend "gcs" {
    bucket = "solid-terraform-state"
  }
}

module "egress_filter" {
  source = "../gcp"
}
