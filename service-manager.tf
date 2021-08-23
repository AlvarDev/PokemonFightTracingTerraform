resource "google_service_account" "manager-sa" {
	account_id   = "manager-sa"
	display_name = "Service Account for Manager service"
}

resource google_cloud_run_service "manager" {
	name     = "manager"
	location = "us-east1"

	template {
		spec {
 			containers {
				image = "gcr.io/${var.project_id}/manager:v0.1"
        env {
					name = "TEMPORAL_FILES_BUCKET"
					value = google_storage_bucket.temporal-files.name
				}
			}
			service_account_name="manager-sa@${var.project_id}.iam.gserviceaccount.com"
		}
	}
}

