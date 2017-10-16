terraform {
  backend "gcs" {
    bucket  = "bucket-12221112"
    path    = "terraform.tfstate"
    credentials = ""
  }
}
