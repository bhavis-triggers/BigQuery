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

