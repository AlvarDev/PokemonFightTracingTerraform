provider google {
  project = var.project_id
}

variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID to use"
}

variable "project_number" {
  type        = string
  description = "The Google Cloud Project Number to use"
}

variable "project_hash" {
  type        = string
  description = "Hash for storage name"
}

variable "source_project_id" {
  type	      = string
  description = "Source project to take images"
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "run.googleapis.com",
    "appengine.googleapis.com",
    "firestore.googleapis.com",
    "vision.googleapis.com",
    "cloudbuild.googleapis.com"
  ]
}

resource "google_project_service" "gcp_services" {
  count   = length(var.gcp_service_list)
  service = var.gcp_service_list[count.index]
  project = var.project_id
  disable_dependent_services = true
}

