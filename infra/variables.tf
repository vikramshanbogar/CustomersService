variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "customers-service"
}

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
  default     = "vikramsvk1/customer_service:mysql"
}

variable "db_password" {
  description = "Password for MySQL database"
  type        = string
  default     = "password123"
  sensitive   = true
}