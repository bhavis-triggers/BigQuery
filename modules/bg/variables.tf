variable "dataset_id"{
    type= string
    default = "example_dataset_dev"
}

/*variable "labels"{
    type=map(string)
    validation {
        condition = contains(keys(var.labels), "app-id") && contains(keys(var.labels), "app-own") && contains(keys(var.labels), "res-name")
        error_message = "You must provide mandatory labels: environment and managed_by."
  }
}*/
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

variable "access"{
    type = list(object({
        role = string
        group_by_email = optional(string)
        user_by_email = optional(string)
    }))
    default=[]
}

variable "dataset"{
    type = list(object({
        dataset_id = string
        dataset_name = optional(string)
        dataset_desc = optional(string)
        labels = map(string)
        /*iam_bindings = optional(list(object{
            role = optional(string)
            group_by_email = optional(string)
            user_by_email = optional(string)
        }))*/
    }))
}