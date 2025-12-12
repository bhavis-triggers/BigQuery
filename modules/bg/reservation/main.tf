resource "google_bigquery_reservation" "reservations" {
    name    = var.reserve-name
    project = var.project-id
    location = var.location
    slot_capacity = 0
    edition = var.edition
    ignore_idle_slots = false
    concurrency = 0
    secondary_location = var.sec_loc
}

resource "google_bigquery_reservation_assignment" "assignment" {
    for_each    = var.assign_projects
    assignee    = "projects/${each.key}"
    job_type    = each.value.job_type
    reservation = google_bigquery_reservation.reservations.name
    location    = var.location
}