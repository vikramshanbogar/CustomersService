variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "db_password" {
  description = "Password for MySQL database"
  type        = string
  default     = "password123"
  sensitive   = true
}