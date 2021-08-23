# Permission for Cloud Builds
# resource "google_project_iam_member" "cloud_build_storage" {
#   role    = "roles/storage.objectViewer"
#   member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
# }

# Files Holder bucket
resource "google_storage_bucket" "temporal-files" {
  name  = "temporal-files-${var.project_hash}"
  location = "US-EAST1"
  force_destroy = true

  uniform_bucket_level_access = true
}

# Permissions for Files Holder
resource "google_storage_bucket_iam_member" "temporal-files-service-manager-writer" {
  bucket = google_storage_bucket.temporal-files.name
  role = "roles/storage.objectAdmin"
  member = "serviceAccount:manager-sa@${var.project_id}.iam.gserviceaccount.com"
}
