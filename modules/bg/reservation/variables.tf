variable "project-id" {
    type = string
}

variable "reserve-name" {
    type = string
}

variable "edition" {
    type = string
    default = "ENTERPRISE_PLUS"
}

variable "location" {
    type = string
    default = "east-us4"
}

variable "slot" {
    type = number
}

variable "sec_loc" {
    type = string
    default = null
}

variable "assign_projects" {
    type = map(object({
        job_type = string
    }))
    default = {}
}

/*variable "" {
    type = string
}

variable "" {
    type = string
}*/