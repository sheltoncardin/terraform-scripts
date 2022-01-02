provider "google" {
  project     = local.project-id
  region      = "us-central1"
}

module "project-iam-binding"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  bindings= {
    "roles/owner"  = ["group:dm-nv-gcp-poc-admins@datametica.com"]
  }
}

module "project-iam-binding"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  bindings= {
    "roles/viewer"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/dataflow.admin"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/composer.user"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/compute.osLogin"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/storage.objectAdmin"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/bigquery.user"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/bigquery.jobUser"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/bigquery.dataEditor"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/container.developer"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/secretmanager.viewer"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/iap.tunnelResourceAccessor"  = ["group:dm-nv-gcp-poc-developers@datametica.com"]
    "roles/compute.instanceAdmin" = ["group:dm-nv-gcp-poc-developers@datametica.com"]
  }
}

module "project-iam-binding"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  bindings= {
    "roles/notebooks.admin"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/viewer"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/bigquery.dataEditor"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/storage.legacyBucketReader"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/storage.objectAdmin"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
  }
}

locals {
  project-id = "dm-suraj-scripts"
}