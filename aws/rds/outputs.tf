output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_username" {
  value = aws_db_instance.postgres.username
}

output "db_password" {
  value     = random_password.postgres.result
  sensitive = true
}