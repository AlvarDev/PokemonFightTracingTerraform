resource "google_service_account" "pokemon-sa" {
	account_id   = "pokemon-sa"
	display_name = "Service Account for Pokemon service"
}

resource google_cloud_run_service "pokemon" {
	name     = "pokemon"
	location = "southamerica-east1"

	template {
		spec {
 			containers {
				image = "gcr.io/${var.source_project_id}/pokemon:latest"
			}
			service_account_name="pokemon-sa@${var.project_id}.iam.gserviceaccount.com"
		}
	}
}

data google_iam_policy "run_invoker_for_pokemon" {
	binding {
		role = "roles/run.invoker"
		members = [
			"serviceAccount:pokemanager-sa@${var.project_id}.iam.gserviceaccount.com",
		]
	}
}

resource google_cloud_run_service_iam_policy "pokemon_invokers" {
	service     = google_cloud_run_service.pokemon.name
	location    = google_cloud_run_service.pokemon.location
	policy_data = data.google_iam_policy.run_invoker_for_pokemon.policy_data
}
