/*resource "google_bigquery_reservation" "reservations" {
    name    = var.reserve-name
    project = var.project-id
    location = var.location
    slot_capacity = 50
    edition = var.edition
    ignore_idle_slots = false
    concurrency = 0
}

resource "google_bigquery_reservation_assignment" "assignment" {
    for_each    = var.assign_projects
    assignee    = "projects/${each.key}"
    job_type    = each.value.job_type
    reservation = google_bigquery_reservation.reservations.name
    location    = var.location
}*/

resource "google_bigquery_reservation" "reservation" {
  for_each = var.reservations
  name         = each.value.name
  project      = each.value.project_id
  location     = each.value.location
  #reservation_id = each.key

  slot_capacity = each.value.slot_capacity
}

resource "google_bigquery_reservation_assignment" "assignment" {
  for_each = {
    for a in var.assignments :
    "${a.reservation_name}-${a.assignee_type}-${a.assignee_id}" => a
  }

  project  = each.value.project_id
  location = each.value.location

  reservation = google_bigquery_reservation.reservation[
    each.value.reservation_name
  ].id

  assignee = (
    each.value.assignee_type == "PROJECT"
    ? "projects/${each.value.assignee_id}"
    : "projects/${split(":", each.value.assignee_id)[0]}/datasets/${split(":", each.value.assignee_id)[1]}"
  )
  job_type = each.value.job_type
}
