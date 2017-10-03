provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "default" {
  name         = "server1"
  machine_type = "f1-micro"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  attached_disk {
   source      = "${google_compute_disk.data_disk.self_link}"
   device_name = "${google_compute_disk.data_disk.name}"
  }

}

resource "google_compute_disk" "data_disk" {
  name = "crypto-data-disk"
  type = "pd-standard"
  zone = "${var.zone}"
  size = "50"
}
