resource "google_bigquery_reservation" "this" {
  name           = var.name
  project        = var.project_id
  location       = var.location
  slot_capacity  = var.slot_capacity
  edition        = var.edition

  lifecycle {
    prevent_destroy = true
  }
}
