resource "google_service_account" "pokemanager-sa" {
	account_id   = "pokemanager-sa"
	display_name = "Service Account for Pokemanager service"
}

resource google_cloud_run_service "pokemanager" {
	name     = "pokemanager"
	location = "southamerica-east1"

	template {
		spec {
 			containers {
				image = "gcr.io/${var.source_project_id}/pokemanager:v0.7"
				env {
					name = "POKEMON_URL"
					value = google_cloud_run_service.pokemon.status[0].url
				}
				env{
					name = "FIGHT_URL"
					value = google_cloud_run_service.fight.status[0].url
				}
			}
			service_account_name="pokemanager-sa@${var.project_id}.iam.gserviceaccount.com"
		}
	}
}

data google_iam_policy "run_invoke_all_users" {
	binding {
		role = "roles/run.invoker"
		members = [
			"allUsers",
		]
	}
}

resource google_cloud_run_service_iam_policy "pokemanager_all_users" {
	service     = google_cloud_run_service.pokemanager.name
	location    = google_cloud_run_service.pokemanager.location
	policy_data = data.google_iam_policy.run_invoke_all_users.policy_data
}
