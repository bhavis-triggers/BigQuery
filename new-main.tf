locals {
  config = yamldecode(file("reservation.yaml"))

  reservations = flatten([
    for env, env_cfg in local.config.environments : [
      for res in env_cfg.reservations : {
        key            = "${env}-${res.project_id}-${res.name}"
        env            = env
        project_id     = res.project_id
        name           = "${res.name}-${env}"
        slot_capacity  = res.slot_capacity
        edition        = res.edition
        location       = res.location
        assignments    = try(res.assignments, [])
      }
    ]
  ])

  assignments = flatten([
    for r in local.reservations : [
      for a in r.assignments : {
        key           = "${r.env}-${r.name}-${a.project_id}-${a.job_type}"
        reservation   = r.name
        project_id    = a.project_id
        location      = r.location
        job_type      = a.job_type
        assignee     = a.assignee_id
      }
    ]
  ])
}


module "reservations" {
  source = "./modules/new-reserv"

  for_each = {
    for r in local.reservations : r.key => r
  }

  name          = each.value.name
  project_id   = each.value.project_id
  location     = each.value.location
  slot_capacity= each.value.slot_capacity
  edition      = each.value.edition
}

module "assignments" {
  source = "./modules/new-assign"

  for_each = {
    for a in local.assignments : a.key => a
  }

  project_id   = each.value.project_id
  location     = each.value.location
  reservation = each.value.reservation
  job_type    = each.value.job_type
}
