resource "google_compute_firewall" "allow-icmp-access" {
  name    = "allow-icmp-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "icmp"
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane", "worker-node"]
}
resource "google_compute_firewall" "allow-ssh-access" {
  name    = "allow-ssh-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["controll-plane", "worker-node"]
}
resource "google_compute_firewall" "allow-kubernetes-apiserver-access" {
  name    = "allow-kubernetes-apiserver-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["6443"]
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane"]
}

resource "google_compute_firewall" "allow-etcd-api-access" {
  name    = "allow-etcd-api-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["2379", "2380"]
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane"]
}

resource "google_compute_firewall" "allow-kubelet-api-access" {
  name    = "allow-kubelet-api-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["10250"]
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane", "worker-node"]
}

resource "google_compute_firewall" "allow-kube-scheduler-access" {
  name    = "allow-kube-scheduler-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["10251"]
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane"]
}

resource "google_compute_firewall" "allow-kube-controller-manager-access" {
  name    = "allow-kube-controller-manager-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["10252"]
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane"]
}

resource "google_compute_firewall" "allow-nodeport-access" {
  name    = "allow-nodeport-access"
  network = google_compute_network.k8s-vpc.name
  allow {
    protocol = "tcp"
    ports = ["30000-32767"]
  }
  source_ranges = [var.vpc_subnet]
  target_tags = ["controll-plane"]
}