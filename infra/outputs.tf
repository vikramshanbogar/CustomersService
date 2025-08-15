output "service_url" {
  description = "URL to access the service"
  value       = "http://${module.ecs.nlb_dns_name}:8080"
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = module.rds.rds_endpoint
}

output "database_connection_string" {
  description = "Database connection string for local testing"
  value       = "jdbc:mysql://${module.rds.rds_endpoint}:3306/customersDB"
}

output "database_credentials" {
  description = "Database credentials"
  value = {
    username = module.rds.database_username
    password = var.db_password
    database = module.rds.database_name
  }
  sensitive = true
}