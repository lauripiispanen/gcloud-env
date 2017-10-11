variable "region" {
  type    = "string"
  default = "europe-west1"
}

variable "zone" {
  type    = "string"
  default = "europe-west1-b"
}

variable "project" {
  type    = "string"
}

variable "image" {
  type    = "string"
  default = "ubuntu-os-cloud/ubuntu-1704"
}

variable "public_key_path" {
  default = "~/.ssh/gcloud_id_rsa.pub"
}
