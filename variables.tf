variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default     = "astrafy-bitcoin-project"
}

variable "location" {
  description = "The location for BigQuery datasets"
  type        = string
  default     = "US"
}

variable "service_account" {
  description = "The id for the service account."
  type        = string
  default     = "service-account"
}

variable "billing_account" {
  description = "The id for the billing account."
  type        = string
  default     = "01FF90-FB0C88-E58BED"
}

variable "staging_id" {
  description = "The id for the staging dataset in BigQuery"
  type        = string
  default     = "staging"
}

variable "data_marts_id" {
  description = "The id for the data_marts dataset in BigQuery"
  type        = string
  default     = "data_marts"
}