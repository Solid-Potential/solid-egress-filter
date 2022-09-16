resource "google_service_account" "service_account" {
  account_id   = var.sa_name
  display_name = "solid egress filter Service Account"
}