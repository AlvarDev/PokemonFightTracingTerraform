resource "google_service_account" "fight-sa" {
	account_id   = "fight-sa"
	display_name = "Service Account for Fight service"
}

resource google_cloud_run_service "fight" {
	name     = "fight"
	location = "southamerica-east1"

	template {
		spec {
 			containers {
				image = "gcr.io/${var.source_project_id}/fight:latest"
			}
			service_account_name="fight-sa@${var.project_id}.iam.gserviceaccount.com"
		}
	}
}

data google_iam_policy "run_invoker_for_fight" {
	binding {
		role = "roles/run.invoker"
		members = [
			"serviceAccount:pokemanager-sa@${var.project_id}.iam.gserviceaccount.com",
		]
	}
}

resource google_cloud_run_service_iam_policy "fight_invokers" {
	service     = google_cloud_run_service.fight.name
	location    = google_cloud_run_service.fight.location
	policy_data = data.google_iam_policy.run_invoker_for_fight.policy_data
}
