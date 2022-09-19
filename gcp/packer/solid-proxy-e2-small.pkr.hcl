
source "googlecompute" "mitm-proxy" {
  machine_type        = "e2-standard-4"
  project_id          = "solid-egress-filter"
  source_image_family = "ubuntu-1804-lts"
  ssh_username        = "solid-egress-filter"
  startup_script_file = "${path.root}/../config/startup.sh"
  zone                = "europe-west1-b"
}

build {
  name = "solid-proxy-disk"
  sources = ["source.googlecompute.mitm-proxy"]
  # provisioner "file"{
  #   source = ""
  #   destination ="/home/solid-egres-filter/mitm-config"
  # }
}
