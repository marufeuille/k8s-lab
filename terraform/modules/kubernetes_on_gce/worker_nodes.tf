variable "worker_nodes_info" {
  type = map
  default = {
    node-1 = {
      name = "self-k8s-worker-1"
      zone = "asia-northeast1-a"
      machine_type = "e2-standard-4"
    }
    node-2 = {
      name = "self-k8s-worker-2"
      zone = "asia-northeast1-a"
      machine_type = "e2-standard-4"
    }
    node-3 = {
      name = "self-k8s-worker-3"
      zone = "asia-northeast1-a"
      machine_type = "e2-standard-4"
    }
  }
}

variable "worker_node_boot_image" {
  default =  "ubuntu-os-cloud/ubuntu-1804-lts"
}

resource "google_compute_disk" "worker_node_gce_storage" {
  for_each = var.worker_nodes_info
  name  = "${each.value.name}-disk"
  type  = "pd-ssd"
  zone  = "asia-northeast1-a"
  physical_block_size_bytes = 4096
}

resource "google_compute_instance" "worker_node" {
  for_each     = var.worker_nodes_info
  name         = each.value.name
  zone         = each.value.zone
  machine_type = each.value.machine_type
  can_ip_forward = true

  tags = ["k8s", "worker-node"]

  boot_disk {
    initialize_params {
      image = var.worker_node_boot_image
    }
  }

  attached_disk{
    source = google_compute_disk.worker_node_gce_storage[each.key].id
  }

  network_interface {
    network = google_compute_network.k8s-vpc.id
    subnetwork = google_compute_subnetwork.k8s-subnet.id
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.k8s-worker-gce.email
    scopes = ["cloud-platform"]
  }
}