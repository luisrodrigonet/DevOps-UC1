output "jupyter_url" {
  value = "http://localhost:8888"
}

output "postgres_connection" {
  value = "postgres://${var.db_user}:${var.db_password}@localhost:5432/${var.db_name}"
  sensitive = true
}
