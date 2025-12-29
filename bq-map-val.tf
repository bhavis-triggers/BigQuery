locals {
  cfg     = yamldecode(file(var.config_file))

  # Mandatory labels defined in root (global)
  default_label = {           #default labels - user provides mandatory or custom labels
    environment = var.environment
    #project_id = var.gcp_project_id
    app-id = var.app-id
    app-own = var.app-own
    res-name = var.res-name
  }
  role_map = {
    "owner" = "roles/bigquery.dataOwner"
    "writer" = "roles/bigquery.dataEditor"
    "reader" = "roles/bigquery.dataViewer"
    "admin" = "roles/bigquery.admin"
    "customEditor" = "organizations/208304944027/roles/BigQueryDataEditor"
  }
  dataset = flatten([
    for ds in local.cfg["dataset"] : {
      dataset_id = "${ds.dataset_id}_${var.env}"
      friendly_name               = try("${ds.dataset_name}", ds.dataset_id)
      description                 = try(ds.dataset_desc, null)
      access_roles                = try(ds.access_roles, {})
      location                    = try(ds.location, "asia-south2")
      labels                      = merge(local.default_label, try(ds.labels,{}))
      iam_bindings = {
        role = ""
        group_by_email = ""
        user_by_email = ""
      }
    
      /*flatten([
        for env, roles in try(ds.access_roles, {}) :
      lower(env) == lower(var.env) ? flatten([
        for primitive, members in roles :
        contains(keys(local.role_map), primitive) ? concat(
          [for g in try(members.groups,[]) : {role = local.role_map[primitive], group_by_email=g}],
          [for g in try(members.service_accounts,[]) : {role = local.role_map[primitive], user_by_email=sa}],
          [for g in try(members.users,[]) : {role = local.role_map[primitive], user_by_email=u}]
        ) : []
      ]) :[]
      ])*/
    }
  ])
}
/*module "dataset" {
  source = "./modules/bg"

  #for_each = local.dataset_config

  dataset = local.dataset
  #project = var.gcp_project_id
  # Send merged mandatory + custom labels
  #labels = merge(
  #  local.default_label,
  #  try(each.value.labels, {})   # safe fallback if YAML missing
  #)
}

module "bigquery_reservation" {
  for_each = local.reservation_config
  source = "./modules/bg/reservation"
  project-id = each.value.project-id
  location = each.value.location
  slot = each.value.slot
  reserve-name = "${each.value.reserve-name}-${each.value.project-id}-0004678-bg-reserv"
  edition = each.value.edition
  #sec_loc = each.value.sec_loc
  assign_projects = each.value.assign_projects
}*/

module "bg_replica" {
  source = "./modules/replica"
  dataset_id = "replica dataset"
  location = "us-east4"
  #replica_location = "us-central1"
  project = var.gcp_project_id
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