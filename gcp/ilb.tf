# forwarding rule
resource "google_compute_forwarding_rule" "egress_filter_forwarding_rule" {
  name            = "egress-filter-forwarding-rule"
  backend_service = google_compute_region_backend_service.egress_filter_backend.id
  region = var.region
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  allow_global_access   = true
  project               = var.project
  network               = var.vpc_name
  subnetwork            = var.subnet_name
}

# backend service
resource "google_compute_region_backend_service" "egress_filter_backend" {
  name   = "egress-filter-ilb-backend"
  region = var.region

  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_region_health_check.egress_filter.id]

  backend {
    group          = google_compute_region_instance_group_manager.egress_filter.instance_group
    balancing_mode = "CONNECTION"
  }
}

resource "google_compute_region_health_check" "egress_filter" {
  name   = "egress-filter-health-check"
  region = var.region

  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 5
  unhealthy_threshold = 10

  tcp_health_check {
    port = 80
  }
}