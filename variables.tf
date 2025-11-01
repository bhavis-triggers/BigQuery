variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
  validation{
    condition = length(var.gcp_project_id) > 6 && length(var.gcp_project_id) <=20
    error_message = "Project ID must be between 6 to 20"
  }
  default = "gcp_test_bigq_dep"
}
variable "gcp_region" {
  description = "The GCP region"
  type        = string
  default = "asia-south2"
}   
/*variable "gcp_svc_key" {
  description = "Path to the GCP service account key file"
  type        = string
}*/

variable "env"{
    type = "string"
    description="working environment gets tagged"
    default = "dev"
}

variable "resource_tags"{
    type = map(string)
    default = {}
}
