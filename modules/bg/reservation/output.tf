output "reservation_id" {
    value = [
    for r in google_bigquery_reservation.reservation : r.name
    ]
}