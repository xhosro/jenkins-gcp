output "jenkins_url" {
  value = "http://${google_compute_instance.jenkins.network_interface.0.access_config.0.nat_ip}:8080"
}
