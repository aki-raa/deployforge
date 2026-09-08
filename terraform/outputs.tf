output "network_name" {
  description = "DeployForge Docker network"
  value       = docker_network.deployforge.name
}

output "app_container" {
  description = "Application container name"
  value       = docker_container.app.name
}

output "app_url" {
  description = "Application URL"
  value       = "http://localhost:${var.app_external_port}"
}

output "ansible_target" {
  description = "Ansible target container name"
  value       = docker_container.ansible_target.name
}

output "ssh_port" {
  description = "SSH host port for Ansible target"
  value       = var.ssh_external_port
}

output "nginx_url" {
  description = "Nginx reverse proxy URL"
  value       = "http://localhost:${var.nginx_external_port}"
}
