terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

#provider "docker" {}

resource "docker_network" "analysis_net" {
  name = "analysis_network"
}

resource "docker_container" "jupyter" {
  name  = var.jupyter_name
  image = "jupyter/datascience-notebook"
  ports {
    internal = 8888
    external = var.jupyter_port
  }
  networks_advanced {
    name = docker_network.analysis_net.name
  }
}

resource "docker_container" "postgres" {
  name  = var.postgres_name
  image = "postgres:15"
  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]
  ports {
    internal = 5432
    external = var.postgres_port
  }
  networks_advanced {
    name = docker_network.analysis_net.name
  }
}

resource "docker_container" "minio" {
  name  = var.minio_name
  image = "minio/minio"
  command = ["server", "/data"]
  env = [
    "MINIO_ACCESS_KEY=${var.minio_access_key}",
    "MINIO_SECRET_KEY=${var.minio_secret_key}"
  ]
  ports {
    internal = 9000
    external = var.minio_port
  }
  networks_advanced {
    name = docker_network.analysis_net.name
  }
}