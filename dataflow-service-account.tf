provider "google" {
  project     = local.project-id
  region      = "us-central1"
}


# Dataflow Serivce account
resource "google_service_account" "dataflow_sa" {
  account_id   = "sa-nv-poc-dataflow"
  display_name = "A service account that sa-nv-poc-composer@datametica-poc.iam.gserviceaccount.com can use"
}

resource "google_service_account_iam_member" "dataflow-service-account" {
  service_account_id = "${google_service_account.dataflow_sa.name}"
  role               = ["roles/iam.serviceAccountUser",
                        "roles/bigquery.jobUser",
                        "roles/bigquery.user",
                        "roles/bigquery.dataEditor",
                        "roles/storage.legacyBucketReader",
                        "roles/storage.objectAdmin"]
  member             = "user:sa-nv-poc-composer@datametica-poc.iam.gserviceaccount.com"
}


# Composer Service Account
resource "google_service_account" "composer_sa" {
  account_id   = "sa-nv-poc-composer"
  display_name = "None"
}

resource "google_service_account_iam_member" "composer-service-account" {
  service_account_id = "${google_service_account.composer_sa.name}"
  role               = ["roles/composer.worker",
                        "roles/dataflow.admin",
                        "roles/bigquery.user",
                        "roles/bigquery.jobUser",
                        "roles/bigquery.dataEditor",
                        "roles/storage.legacyBucketReader",
                        "roles/storage.objectAdmin"]
}



# VM Service Account
resource "google_service_account" "vm_sa" {
  account_id   = "sa-nv-poc-jump-box"
  display_name = "service account for dm-nv-gcp-poc-developers@datametica.com"
}

resource "google_service_account_iam_member" "vm-service-account" {
  service_account_id = "${google_service_account.vm_sa.name}"
  member             = "user:dm-nv-gcp-poc-developers@datametica.com"
  }


# Looker Service Account
resource "google_service_account" "looker_sa" {
  account_id   = "sa-nv-poc-looker"
  display_name = "None"
}

resource "google_service_account_iam_member" "looker-service-account" {
  service_account_id = "${google_service_account.looker_sa.name}"
  role               =["roles/bigquery.user",
                        "roles/bigquery.jobUser",
                        "roles/bigquery.dataViewer",
                        "roles/bigquery.dataEditor"]
  }



# Data Fusion Service Account
resource "google_service_account" "data_fusion_sa" {
  account_id   = "sa-nv-poc-data-fusion"
  display_name = "None"
}

resource "google_service_account_iam_member" "looker-service-account" {
  service_account_id = "${google_service_account.looker_sa.name}"
  role               = ["roles/datafusion.runner",
                        "roles/dataproc.admin",
                        "roles/dataproc.worker",
                        "roles/bigquery.dataOwner",
                        "roles/bigquery.user",
                        "roles/bigquery.jobUser",
                        "roles/storage.admin"]
  }


# Vertex AI Notebook Service Account
resource "google_service_account" "data_fusion_sa" {
  account_id   = "sa-nv-poc-data-fusion"
  display_name = "None"
}

resource "google_service_account_iam_member" "data-fusion-service-account" {
  service_account_id = "${google_service_account.data_fusion_sa.name}"
  role               = ["roles/bigquery.dataEditor",
                        "roles/bigquery.user",
                        "roles/bigquery.jobUser",
                        "roles/storage.legacyBucketReader",
                        "roles/storage.objectAdmin"]
}
