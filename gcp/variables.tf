variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  description = "Prefix for all resource names. Allows to deploy multiple instances in the same project."
  type        = string
  default     = ""
}

locals {
  prefix = length(var.prefix) == 0 ? "" : "${var.prefix}-"
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "disk_size_gb" {
  type    = number
  default = 50
}

variable "tags" {
  default = []
  type    = list(string)
}
