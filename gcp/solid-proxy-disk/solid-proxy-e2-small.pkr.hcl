
source "googlecompute" "mitm-proxy" {
  machine_type        = "e2-small"
  project_id          = "solid-egress-filter"
  source_image        = "debian-11-bullseye-v20220822"
  ssh_username        = "debian"
  startup_script_file = "${path.root}/../config/startup.sh"
  zone                = "europe-west1-b"
}

build {
  name = "solid-proxy-disk"
  sources = ["source.googlecompute.mitm-proxy"]

}
