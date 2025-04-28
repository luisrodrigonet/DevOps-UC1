output "jupyter_url" {
  value = "http://localhost:${var.jupyter_port}"
}

output "postgres_host" {
  value = "localhost:${var.postgres_port}"
}

output "minio_console" {
  value = "http://localhost:${var.minio_port}"
}
