# App Engine init, requiered to use Firestore.
resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = "us-east1"
  database_type = "CLOUD_FIRESTORE"
}
