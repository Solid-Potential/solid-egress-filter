
source "googlecompute" "squid-proxy" {
  machine_type        = "e2-standard-4"
  project_id          = "solid-egress-filter"
  source_image_family = "ubuntu-1804-lts"
  ssh_username        = "solid-egress-filter"
  startup_script_file = "${path.module}/../config/startup.sh"
  network             = "projects/solid-egress-filter/global/networks/dev-vpc"
  subnetwork          = "projects/solid-egress-filter/regions/europe-west1/subnetworks/dev-subnet"
  zone                = "europe-west1-b"
}

build {
  name = "solid-proxy-disk"
  sources = ["source.googlecompute.squid-proxy"]

  provisioner "file"{
    source = ""
    destination ="/home/solid-egres-filter/squid-config"
  }
}
