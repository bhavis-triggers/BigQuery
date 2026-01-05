resource "google_bigquery_dataset" "dttest" {
    dataset_id = var.dataset_id
    location = var.location
    project = var.gcp_project_id
}

resource "google_bigquery_job" "replica_query" {
  depends_on = [google_bigquery_dataset.dttest]
  query {
    query = "ALTER SCHEMA `{var.gcp_project_id}.${var.dataset_id}` ADD REPLICA `replica` OPTIONS(location='us-central1');"
    use_legacy_sql = false
  }
}

resource "null_resource" "dataset_dep" {
    /*for_each = {for ds in var.dataset: ds.dataset_id => ds}
    depends_on = [
        google_bigquery_dataset.dttest
    ]*/
    #provisioner "local-exec" {
        #command = "echo Dataset ${each.key} created."
        #command = "bq query --nouse_legacy_sql=false 'ALTER SCHEMA `${var.gcp_project_id}.${each.value.dataset_id}` ADD REPLICA ${var.replica_location}'"
    #}
    replica_configuration {
        source_dataset {
            project_id = var.gcp_project_id
            dataset_id = google_bigquery_dataset.dttest.dataset_id
        }
    }
}