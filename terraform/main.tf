terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_network" "deployforge" {
  name = "deployforge-net"
}

resource "docker_container" "app" {
  name         = "deployforge-app"
  image        = "deployforge-app"
  network_mode = docker_network.deployforge.name

  ports {
    internal = 8080
    external = 8080
  }
}

resource "docker_container" "ansible_target" {
  name         = "deployforge-ansible-target"
  image        = "deployforge-ansible-target"
  network_mode = docker_network.deployforge.name

  ports {
    internal = 22
    external = 2222
  }
}

