output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = aws_lb.customers_service.dns_name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.customers_service.repository_url
}

output "service_url" {
  description = "URL to access the service"
  value       = "http://${aws_lb.customers_service.dns_name}:8080"
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "database_connection_string" {
  description = "Database connection string for local testing"
  value       = "jdbc:mysql://${aws_db_instance.mysql.endpoint}:3306/customersDB"
}

output "database_credentials" {
  description = "Database credentials"
  value = {
    username = "root"
    password = var.db_password
    database = "customersDB"
  }
  sensitive = true
}