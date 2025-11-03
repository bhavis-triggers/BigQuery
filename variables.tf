
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

variable "config_file" {
  type    = string
  default = "bq-config.yaml"
}

variable "environment" {
  type    = string
  default = "dev"
}
/*
variable "app-id"{
  type = string
}

variable "app-own"{
  type = string
}

variable "res-name"{
  type = string
}*/