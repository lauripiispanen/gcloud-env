provider "google" {
  version     = "~> 2.0.0"
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "default" {
  name         = "server1"
  machine_type = "f1-micro"
  zone         = "${var.zone}"

  tags         = [ "commits", "limited-ssh" ]

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

  metadata {
    sshKeys = "ubuntu:${file("${var.public_key_path}")}"
  }

  provisioner "local-exec" {
    // remove potentially offending local known_hosts key for recreated host
    command = "ssh-keygen -R ${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
  }

  provisioner "local-exec" {
    command = "sleep 30; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i gce.py site.yml --vault-password-file ./.vault_password --private-key ${var.private_key_path}"
  }

}

resource "google_compute_firewall" "allow-selected-ssh" {
    name = "allow-selected-ssh"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["22"]
    }
    source_ranges = ["${var.ssh_inbound_ip}/32"]
    target_tags = ["limited-ssh"]
}

resource "google_compute_firewall" "deny-all-ssh" {
    name = "deny-all-ssh"
    network = "default"

    deny {
        protocol = "tcp"
        ports = ["22"]
    }
    source_ranges = ["0.0.0.0/0"]
#    source_ranges = ["192.168.1.1/32"]
    target_tags = ["limited-ssh"]
    priority = 2000
}
