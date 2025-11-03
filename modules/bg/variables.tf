variable "config_file" {
  type    = string
  default = "bq-map-val.yaml"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "dataset_id"{
    type= string
    default = "example_dataset_dev"
}

variable "labels"{
    type=map(string)
    default = {}
}
