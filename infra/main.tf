terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  project_name = var.project_name
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"
  
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  vpc_cidr_block      = module.vpc.vpc_cidr_block
  subnet_ids          = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  private_subnet_ids  = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
  docker_image        = var.docker_image
  aws_region          = var.aws_region
  
  environment_variables = [
    {
      name  = "SPRING_DATASOURCE_URL"
      value = "jdbc:mysql://${module.rds.rds_endpoint}/customersDB"
    },
    {
      name  = "SPRING_DATASOURCE_USERNAME"
      value = "root"
    },
    {
      name  = "SPRING_DATASOURCE_PASSWORD"
      value = var.db_password
    },
    {
      name  = "SPRING_PROFILES_ACTIVE"
      value = "mysql"
    }
  ]
}

# RDS Module
module "rds" {
  source = "./modules/rds"
  
  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
  ecs_security_group_id  = module.ecs.ecs_security_group_id
  database_password      = var.db_password
}

# VPN Module
module "vpn" {
  source = "./modules/vpn"
  
  project_name      = var.project_name
  vpc_cidr_block    = module.vpc.vpc_cidr_block
  public_subnet_id  = module.vpc.public_subnet_1_id
}