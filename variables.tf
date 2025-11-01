variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
  validation{
    condition = length(var.gcp_project_id) > 6 && length(var.gcp_project_id) <=25
    error_message = "Project ID must be between 6 to 20"
  }
  default = "gleaming-nomad-474505-r3"
}
variable "gcp_region" {
  description = "The GCP region"
  type        = string
  default = "asia-south2"
}   
/*variable "gcp_svc_key" {
  description = "Path to the GCP service account key file"
  type        = string
  default = "bhavis-triggers/BigQuery/gleaming-nomad-474505-r3-fb906b46b1b7.json"
}*/

variable "env"{
    type = string
    description="working environment gets tagged"
    default = "dev"
}

variable "resource_tags"{
    type = map(string)
    default = {}
}
