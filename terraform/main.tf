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
}
