variable "project" {
  type    = string
  default = null
}

variable "region" {
  type    = string
  default = null
}

variable "vpc_name" {
  type    = string
  default = "default"
}

variable "subnet_name" {
  type    = string
  default = "default"
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

variable "sa_name"{
  type = string
  default = "solid-egress-filter-sa"
}
