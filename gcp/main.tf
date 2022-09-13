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
