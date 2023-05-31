output "bucket_url" {
  value = google_storage_bucket.my_bucket.url
}

#output "web_server1_ip" {
#  value = google_compute_instance.web_server1.network_interface[0].access_config[0].nat_ip
#}

#output "web_server2_ip" {
#  value = google_compute_instance.web_server2.network_interface[0].access_config[0].nat_ip
#}

#output "db_server_ip" {
#  value = google_compute_instance.db_server.network_interface[0].access_config[0].nat_ip
#}
