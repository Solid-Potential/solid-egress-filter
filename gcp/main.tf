resource "google_compute_instance_template" "egress_filter" {
  project      = var.project
  name_prefix  = "${local.prefix}egress-filter"
  machine_type = var.machine_type
  region       = var.region

  disk {
    # TODO - base image from packer or with startup script
    # source_image = "projects/${var.image_project}/global/images/family/${var.image_family}"
    boot = true

    disk_type    = "pd-standard"
    disk_size_gb = var.disk_size_gb

    auto_delete = false

    source_image = "source-image-1"
    # TODO KMS support
    # disk_encryption_key {
    # }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name
  }

  can_ip_forward = true

  # TODO
  #   tags = []

  metadata = {
    # TODO - base image from packer or with startup script
    startup-script = templatefile("${path.module}/config/startup.sh", {

    })
  }

  # TODO
  #   service_account {
  #     email  = 
  #     scopes = ["cloud-platform"]
  #   }

  scheduling {
    on_host_maintenance = "MIGRATE"
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "egress_filter" {
  name = "egress-filter-igm"

  base_instance_name = "egress-filter"
  region = var.region

  target_pools = [ google_compute_target_pool.egress_filter.id ]

  version {
    instance_template = google_compute_instance_template.egress_filter.id
  }
}

resource "google_compute_target_pool" "egress_filter" {
  name = "egress-filter-target-pool"
}


resource "google_compute_region_autoscaler" "egress_filter" {
  name   = "egress-filter-autoscaler"
  region = var.region

  target = google_compute_region_instance_group_manager.egress_filter.id

  autoscaling_policy {
    mode = var.autoscaling_mode
    max_replicas    = var.autoscaling_max_replicas
    min_replicas    = var.autoscaling_min_replicas
    cooldown_period = var.autoscaling_cooldown_period

    cpu_utilization {
      target = 0.7
    }
  }
}
