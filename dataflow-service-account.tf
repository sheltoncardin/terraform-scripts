provider "google" {
  project     = local.project-id
  region      = "us-central1"
}

resource "google_service_account" "dataflow_proc" {
  account_id   = "sa-nv-poc-dataflow"
  display_name = "A service account that sa-nv-poc-composer@datametica-poc.iam.gserviceaccount.com can use"
}

resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = "${google_service_account.dataflow_proc.name}"
  role               = "roles/iam.serviceAccountUser"
  member             = "user:jane@example.com"

}