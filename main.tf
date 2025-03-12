// Set google as provider
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

// Create Project and enable necessary services
resource "google_project" "astrafy-bitcoin-project" {
  name            = var.project_id
  project_id      = var.project_id
  billing_account = var.billing_account
  deletion_policy =  "DELETE"
}

resource "google_project_service" "billing_api" {
  project = var.project_id
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "bigquery" {
  project = var.project_id
  service = "bigquery.googleapis.com"
}

//Create service account and set necessary permissions
resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = var.service_account
  display_name = "BigQuery Service Account"
}

resource "google_billing_account_iam_member" "billing_user" {
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "job_user" {
  project = var.project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "data_editor" {
  project    = var.project_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.service_account.email}"
}

// Create staging and data_marts datasets
resource "google_bigquery_dataset" "staging" {
  project     = var.project_id
  dataset_id  = var.staging_id
  location    = var.location
  depends_on = [google_project_service.bigquery]
}

resource "google_bigquery_dataset" "data_marts" {
  project     = var.project_id
  dataset_id  = var.data_marts_id
  location    = var.location
  depends_on = [google_project_service.bigquery]
}




