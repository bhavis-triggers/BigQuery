resource "google_bigquery_reservation_assignment" "this" {
  project      = var.project_id
  location     = var.location
  reservation  = var.reservation
  job_type     = var.job_type
  assignee     = var.assignee
  lifecycle {
    prevent_destroy = true
  }
}
