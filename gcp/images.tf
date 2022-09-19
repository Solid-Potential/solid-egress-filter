
data "packer_version" "version" {}


data "packer_files" "packer_config_dir" {
  directory = "${path.module}/packer"
}


resource "random_string" "random" {
  length  = 6
  special = false
  lower   = true
  numeric = true
}

resource "packer_image" "solid_proxy_image" {
  directory = data.packer_files.packer_config_dir.directory
  force     = true

  ignore_environment = false
  name               = "packer-image-${random_string.random.result}"

  triggers = {
    packer_version = data.packer_version.version.version
    files_hash     = data.packer_files.packer_config_dir.files_hash
  }
}

output "packer_version" {
  value = data.packer_version.version.version
}

output "image_id" {
  value  = packer_image.solid_proxy_image.id
}
