variable "region" {
  type    = "string"
  default = "us-east1"
}

variable "zone" {
  type    = "string"
  default = "us-east1-b"
}

variable "project" {
  type    = "string"
}

variable "image" {
  type    = "string"
  default = "ubuntu-os-cloud/ubuntu-1710"
}

variable "public_key_path" {
  default = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_path" {
  default = "~/.ssh/id_gcloud_rsa"
}

variable "ssh_inbound_ip" {
  type    = "string"
}
