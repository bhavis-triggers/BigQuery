
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
  default = "us-east4"
}  
variable "gcp_replica_region" {
  description = "The GCP replica region"
  type        = string
  default = "us-central1"
} 
variable "resource_tags"{
    type = map(string)
    default = {}
}

variable "config_file" {
  type    = string
  default = "bq-config.yaml"
}
variable "reservation_file" {
  type    = string
  default = "res-config.yaml"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "app-id"{
  type = string
  default = "hid"
}

variable "app-own"{
  type = string
  default = "App00"
}

variable "res-name"{
  type = string
  default = "Apsv"
}
