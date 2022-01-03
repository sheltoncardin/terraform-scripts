resource "google_bigquery_dataset" "default" {
  dataset_id                  = local.id_ml
  friendly_name               = local.name_ml
  location                    = local.location 
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = local.id_staging
  friendly_name               = local.name_staging
  location                    = local.location 
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = local.id_test
  friendly_name               = local.name_test
  location                    = local.location
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = local.id_warehouse
  friendly_name               = local.name_warehouse
  location                    = local.location
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = local.id_scratch
  friendly_name               = local.name_scratch
  location                    = local.location
}


locals {
  id_ml = "datametica_ml"
  name_ml = "datametica_ml"
  location = "us-east1"

  id_staging = "staging"
  name_staging = "staging"

  id_test = "test_1"
  name_test = "test_1"

  id_warehouse = "warehouse"
  name_warehouse = "warehouse"

  id_scratch = "scratch"
  name_scratch = "scratch"
  
}