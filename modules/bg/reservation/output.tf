output "reservation_id" {
    value = google_bigquery_reservation.reservation[each.key].name
}