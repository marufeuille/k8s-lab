variable "control_plane_nodes_info" {
  type = map
  default = {
    node-1 = {
      name = "self-k8s-master-1"
      zone = "asia-northeast1-a"
      machine_type = "e2-standard-4"
    }
  }
}

variable "control_plane_node_boot_image" {
  default =  "ubuntu-os-cloud/ubuntu-1804-lts"
}

resource "google_compute_disk" "control_plane_node_gce_storage" {
  for_each = var.control_plane_nodes_info
  name  = "${each.value.name}-disk"
  type  = "pd-ssd"
  zone  = "asia-northeast1-a"
  physical_block_size_bytes = 4096
}

resource "google_compute_instance" "control_plane_node" {
  for_each     = var.control_plane_nodes_info
  name         = each.value.name
  zone         = each.value.zone
  machine_type = each.value.machine_type
  can_ip_forward = true

  tags = ["k8s", "controll-plane"]

  boot_disk {
    initialize_params {
      image = var.control_plane_node_boot_image
    }
  }

  attached_disk{
    source = google_compute_disk.control_plane_node_gce_storage[each.key].id
  }

  network_interface {
    network = google_compute_network.k8s-vpc.id
    subnetwork = google_compute_subnetwork.k8s-subnet.id
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.k8s-master-gce.email
    scopes = ["cloud-platform"]
  }
}