terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_network" "deployforge" {
  name = var.network_name
}

resource "docker_container" "app" {
  name         = var.app_container_name
  image        = var.app_image
  network_mode = docker_network.deployforge.name

  ports {
    internal = var.app_internal_port
    external = var.app_external_port
  }
}

resource "docker_container" "ansible_target" {
  name         = var.target_container_name
  image        = var.target_image
  network_mode = docker_network.deployforge.name

  ports {
    internal = 22
    external = var.ssh_external_port
  }

  ports {
    internal = 80
    external = var.nginx_external_port
  }
}
