variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for VPN association"
  type        = string
}

variable "client_cidr_block" {
  description = "CIDR block for VPN clients"
  type        = string
  default     = "10.1.0.0/16"
}