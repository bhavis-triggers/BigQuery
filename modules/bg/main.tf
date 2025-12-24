resource "google_bigquery_dataset" "dataset" {
    for_each = {for ds in var.dataset: ds.dataset_id => ds}
    dataset_id = each.value.dataset_id
    friendly_name               = each.value.dataset_name
    description                 = each.value.dataset_desc
    location                    = var.gcp_region
    labels                      = each.value.labels
    project = var.gcp_project_id
    dynamic "access"{
        for_each = each.value.iam_bindings
        content{
            role = try(access.value.role, null)
            group_by_email = try(access.value.group_by_email, null)
            user_by_email  = try(access.value.user_by_email, null)
        }
    }
}

resource "google_bigquery_dataset" "dttest" {
    dataset_id = var.dataset_id
    location = var.gcp_region
    project = var.gcp_project_id
}

resource "null_resource" "dataset_dep" {
    for_each = {for ds in var.dataset: ds.dataset_id => ds}
    depends_on = [
        google_bigquery_dataset.dttest
    ]
    provisioner "local-exec" {
        #command = "echo Dataset ${each.key} created."
        command = "bq query --nouse_legacy_sql=false 'ALTER SCHEMA `${var.gcp_project_id}.${each.value.dataset_id}` ADD REPLICA ${var.replica_location}'"
    }
}
