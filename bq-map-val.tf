locals {
  yaml_config     = yamldecode(file(var.config_file))
  dataset_config  = try(local.yaml_config.datasets, {})

  # Mandatory labels defined in root (global)
  mandatory_labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
module "bigquery" {
  source = "./modules/bg"

  for_each = local.dataset_config

  dataset_id = each.value.dataset_id

  # Send merged mandatory + custom labels
  labels = merge(
    local.mandatory_labels,
    try(each.value.labels, {})   # safe fallback if YAML missing
  )
}
/*locals{
    cfg = yamldecode(file("${path.module}/bq-config.yaml"))

}*/
/*resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "example_dataset_${var.env}"
  friendly_name               = "testing dataset creation"
  description                 = "This is a test description"
  location                    = var.gcp_region
  labels = merge({
    env = var.env
    project = var.gcp_project_id
  },
  var.resource_tags
  )

  access {
    role          = "roles/bigquery.dataOwner"
    user_by_email = google_service_account.bqowner.email
  }*/
  /*access {
    role          = "roles/bigquery.dataViewer"
    user_by_email = var.user_by_email
  }

  access {
    role   = "READER"
    domain = "hashicorp.com"
  }
  delete_contents_on_destroy = true
}

resource "google_service_account" "bqowner" {
  account_id = "bqowner"
  display_name = "Servie account for big query dataset"
}*/