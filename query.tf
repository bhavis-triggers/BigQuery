locals {
  rese = yamldecode(
    file(var.reservation_file)
  )

  reservations = {
    for r in local.rese.reservations :
    r.name => r
  }

  assignments = flatten([
    for r in local.reservations : [
      for a in try(r.assignments, []) : {
        reservation_name = r.name
        project_id       = r.project_id
        location         = r.location
        assignee_type    = a.assignee_type
        assignee_id      = a.assignee_id
        job_type        = try(a.job_type, null)
      }
    ]
  ])
}

module "bigquery_reservation" {
  source = "./modules/bg/reservation"

  reservations = local.reservations
  assignments  = local.assignments
}
