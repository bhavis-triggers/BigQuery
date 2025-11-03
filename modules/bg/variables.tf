variable "dataset_id"{
    type= string
    default = "example_dataset_dev"
}

variable "labels"{
    type=map(string)
    default = {}
}
