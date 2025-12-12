locals {
    reservation_config = {
        dev = {
            project-id = "gleaming-nomad-474505-r3"
            location = "us-east4"
            reserve-name = "marketing-${project-id}-000897-bg-resv"
            slot = 0
            edition = "ENTERPRISE_PLUS"
            sec_loc = "us-central1"
            assign_projects = {
                "gleaming-nomad-474505-r3" = { job_type = "QUERY" }
                "lunar-caster-481015-c0" = { job_type = "QUERY" }
            }
        }
    }
}