# Configuration for calling compoinents on SantoID, more details coming soon

# First Domain
resource "google_firestore_document" "alvardev" {
  collection  = "domains"
  document_id = "alvardev"
  fields      = "{\"something\":{\"mapValue\":{\"fields\":{\"akey\":{\"stringValue\":\"avalue\"}}}}}"
}

# First Domain orc-confir
resource "google_firestore_document" "alvardev-orc-config" {
  collection  = "${google_firestore_document.alvardev.path}/configs"
  document_id = "alvardev-orc-config"
  fields      = "{\"something\":{\"mapValue\":{\"fields\":{\"akey\":{\"stringValue\":\"avalue\"}}}}}"
}
