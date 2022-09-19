resource "google_compute_route" "default_internet_gateway" {
  project          = var.project
  description      = "Default egress route for Solid Egress Filter instances"
  name             = "${local.prefix}default-internet-gateway"
  dest_range       = "0.0.0.0/0"
  tags             = [var.filter_network_tag]
  network          = var.vpc_name
  priority         = 998
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_route" "forward_to_egress_filter" {
  project      = var.project
  description  = "Forward all internet egress to Egress Filter"
  name         = "${local.prefix}forward-to-egress-filter"
  dest_range   = "0.0.0.0/0"
  network      = var.vpc_name
  priority     = 999
  next_hop_ilb = google_compute_forwarding_rule.egress_filter_forwarding_rule.id
}

resource "google_compute_route" "restricted_google_apis" {
  project = var.project
  name    = "${local.prefix}restricted-google-apis"
  # Restricted connectivitiy to google api
  # https://cloud.google.com/vpc-service-controls/docs/set-up-private-connectivity
  dest_range       = "199.36.153.4/30"
  network          = var.vpc_name
  priority         = 997
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_route" "private_google_apis" {
  project = var.project
  name    = "${local.prefix}private-google-apis"
  # Private connectivitiy to google api
  # https://cloud.google.com/vpc-service-controls/docs/set-up-private-connectivity
  dest_range       = "199.36.153.8/30"
  network          = var.vpc_name
  priority         = 997
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_route" "restricted_google_apis_filter" {
  project = var.project
  name    = "${local.prefix}restricted-google-apis-filter"
  # Restricted connectivitiy to google api
  # https://cloud.google.com/vpc-service-controls/docs/set-up-private-connectivity
  tags             = [var.filter_network_tag]
  dest_range       = "199.36.153.4/30"
  network          = var.vpc_name
  priority         = 997
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_route" "private_google_apis_filter" {
  project = var.project
  name    = "${local.prefix}private-google-apis-filter"
  # Private connectivitiy to google api
  # https://cloud.google.com/vpc-service-controls/docs/set-up-private-connectivity
  tags             = [var.filter_network_tag]
  dest_range       = "199.36.153.8/30"
  network          = var.vpc_name
  priority         = 997
  next_hop_gateway = "default-internet-gateway"
}

