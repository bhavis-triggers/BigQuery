resource "google_bigquery_reservation" "this" {
  name           = var.name
  project        = var.project_id
  slot_capacity  = var.slot_capacity
  edition        = var.edition
  location       = var.location

  lifecycle {
    prevent_destroy = true
  }
}
