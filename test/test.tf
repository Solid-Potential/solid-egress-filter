provider "google" {
}

terraform {
  backend "gcs" {
    bucket = "todo"
  }
}

module "egress_filter" {
    source = "../gcp"
    project = "todo"
}