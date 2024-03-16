# gcp provider

provider "google" {
    region = var.gcp_region
    project = var.gcp_project
    credentials = file(var.gcp_svc_key)
}