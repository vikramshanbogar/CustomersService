variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ECS security group ID"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "customersDB"
}

variable "database_username" {
  description = "Database username"
  type        = string
  default     = "root"
}

variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Whether the database is publicly accessible"
  type        = bool
  default     = true
}