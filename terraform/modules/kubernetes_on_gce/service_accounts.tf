resource "google_service_account" "k8s-master-gce" {
  account_id   = "k8s-master-gce"
  display_name = "Service Account"
}

resource "google_service_account" "k8s-worker-gce" {
  account_id   = "k8s-worker-gce"
  display_name = "Service Account"
}