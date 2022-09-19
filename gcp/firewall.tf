resource "google_compute_firewall" "deny_non_filter_egress" {
  project   = var.project
  name      = "${local.prefix}deny-non-filter-egress"
  network   = var.vpc_name
  direction = "EGRESS"

  destination_ranges = ["0.0.0.0/0"]

  deny {
    protocol = "tcp"
    ports    = null # all ports
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow_egress_filter_internet_access" {
  project     = var.project
  name        = "${local.prefix}allow-filter-to-internet"
  network     = var.vpc_name
  direction   = "EGRESS"
  target_tags = [var.filter_network_tag]

  destination_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = null # all ports
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow_health_check" {
  project     = var.project
  name        = "${local.prefix}allow-health-check"
  network     = var.vpc_name
  direction   = "INGRESS"
  target_tags = [var.filter_network_tag]

  source_ranges = [
    # gcp health check range
    # https://cloud.google.com/load-balancing/docs/health-checks#firewall_rules
    "35.191.0.0/16",
    "130.211.0.0/22",
  ]

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
