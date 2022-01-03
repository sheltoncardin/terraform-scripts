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

module "dm-nv-gcp-poc-developers"{
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

module "dm-nv-gcp-poc-ml"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  bindings= {
    "roles/notebooks.admin"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/viewer"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/bigquery.dataEditor"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/storage.legacyBucketReader"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
    "roles/storage.objectAdmin"  = ["group:dm-nv-gcp-poc-ml@datametica.com"]
  }
}

module "sa-nv-poc-dataflow"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  names = [local.dataflow_sa]
  binding_roles = local.dataflow_roles
  }

module "sa-nv-poc-composer"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  names = [local.composer_sa]
  binding_roles = local.composer_roles
  }

module "sa-nv-poc-jump-box"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  binding_roles = local.vm_roles
  }

module "sa-nv-poc-looker"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  binding_roles = local.looker_roles
  }

module "sa-nv-poc-data-fusion"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  binding_roles = local.data_fusion_roles
  }

module "sa-nv-poc-ai-notebook"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  mode="additive"
  names = [local.service_account_user_ai_notebook]
  binding_roles = local.data_fusion_roles
  }

module "composer-iam-permissions"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  binding_roles = local.composer_iam_roles
  }

module "dataflow-vpc-iam-permissions"{
  source="terraform-google-modules/iam/google//modules/project-iam"
  projects=[local.project-id]
  binding_roles = local.dataflow_vpc_iam_roles
  }
















locals {
  project-id = "dm-suraj-scripts"
  dataflow_sa = "sa-nv-poc-dataflow"
  composer_sa = "sa-nv-poc-composer"
  service_account_user_composer = "sa-nv-poc-composer@datametica-poc.iam.gserviceaccount.com"
  dataflow_roles = [
        "${local.project_id}=>roles/iam.serviceAccountUser=>${local.service_account_user_composer}",
        "${local.project_id}=>roles/dataflow.worker",
        "${local.project_id}=>roles/bigquery.jobUser",
        "${local.project_id}=>roles/bigquery.user",
        "${local.project_id}=>roles/bigquery.dataEditor",
        "${local.project_id}=>roles/secretmanager.secretAccessor",
        "${local.project_id}=>roles/cloudkms.cryptoKeyDecrypter",
        ]
  composer_roles = [
        "${local.project_id}=>roles/composer.worker",
        "${local.project_id}=>roles/bigquery.jobUser",
        "${local.project_id}=>roles/bigquery.user",
        "${local.project_id}=>roles/bigquery.dataEditor",
        "${local.project_id}=>roles/dataflow.admin",
        "${local.project_id}=>roles/cloudkms.cryptoKeyDecrypter",
        "${local.project_id}=>roles/cloudkms.cryptoKeyDecrypter",
        "${local.project_id}=>roles/secretmanager.secretAccessor",   
    ]
  
  service_account_user_vm = "dm-nv-gcp-poc-developers@datametica.com"
  vm_roles = [
        "${local.project_id}=>roles/iam.serviceAccountUser=>${local.service_account_user_vm}",
  ]

  looker_roles = [
        "${local.project_id}=>roles/bigquery.jobUser",
        "${local.project_id}=>roles/bigquery.user",
        "${local.project_id}=>roles/bigquery.dataViewer",
    ]
  
  data_fusion_roles = [
        "${local.project_id}=>roles/bigquery.jobUser",
        "${local.project_id}=>roles/bigquery.user",
        "${local.project_id}=>roles/storage.objectAdmin",
        "${local.project_id}=>roles/datafusion.runner",
        "${local.project_id}=>roles/dataproc.admin",
        "${local.project_id}=>roles/dataproc.worker",
  ]

  service_account_user_ai_notebook = "dm-nv-gcp-poc-ml@datametica.com"
  ai_notebook_roles = [
               "${local.project_id}=>roles/iam.serviceAccountUser=>${local.service_account_user_ai_notebook}",
               "${local.project_id}=>roles/bigquery.jobUser",
               "${local.project_id}=>roles/bigquery.user",
  ]

  composer_iam_roles = {
        "roles/compute.networkUser"=["serviceAccount<projectid>@cloudservices.gserviceaccount.com"]
        "roles/container.hostServiceAgentUser"=["serviceAccount<projectid>@container-engine-robot.iam.gserviceaccount.com"]
        "roles/compute.networkUser"=["serviceAccount<projectid>@container-engine-robot.iam.gserviceaccount.com"]
        "roles/composer.sharedVpcAgent"=["<projectid>@cloudcomposer-accounts.iam.gserviceaccount.com"]
    }
  
  dataflow_vpc_iam_roles = {
        "roles/compute.networkUser"=["<projectid>@dataflow-service-producer-prod.iam.gserviceaccount.com"]
        "roles/compute.networkUser"=["sa-nv-poc-dataflow@datametica-poc.iam.gserviceaccount.com"]
  }
}