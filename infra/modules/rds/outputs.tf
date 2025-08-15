output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "database_name" {
  description = "Database name"
  value       = aws_db_instance.mysql.db_name
}

output "database_username" {
  description = "Database username"
  value       = aws_db_instance.mysql.username
}