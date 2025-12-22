output "master_public_ip" {
  description = "IP publique du master Spark"
  value       = google_compute_instance.spark_master.network_interface[0].access_config[0].nat_ip
}

output "master_private_ip" {
  description = "IP privée du master"
  value       = google_compute_instance.spark_master.network_interface[0].network_ip
}

output "workers_public_ips" {
  description = "IPs publiques des workers"
  value       = google_compute_instance.spark_workers[*].network_interface[0].access_config[0].nat_ip
}

output "workers_private_ips" {
  description = "IPs privées des workers"
  value       = google_compute_instance.spark_workers[*].network_interface[0].network_ip
}

output "edge_public_ip" {
  description = "IP publique du edge node"
  value       = google_compute_instance.spark_edge.network_interface[0].access_config[0].nat_ip
}

output "edge_private_ip" {
  description = "IP privée du edge"
  value       = google_compute_instance.spark_edge.network_interface[0].network_ip
}

output "ssh_command_master" {
  description = "Commande SSH pour le master"
  value       = "ssh -i ~/.ssh/id_rsa spark@${google_compute_instance.spark_master.network_interface[0].access_config[0].nat_ip}"
}