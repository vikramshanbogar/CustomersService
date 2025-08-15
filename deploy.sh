#!/bin/bash

# Build the Spring Boot application
./mvnw clean package -DskipTests

# Get ECR repository URL from Terraform output
ECR_REPO=$(terraform output -raw ecr_repository_url)
AWS_REGION=$(terraform output -raw aws_region || echo "ap-south-1")

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO

# Build and tag Docker image
docker build -t customers_service:latest .
docker tag customers_service:latest $ECR_REPO:latest

# Push to ECR
docker push $ECR_REPO:latest

# Update ECS service to use new image
aws ecs update-service --cluster customers-service-cluster --service customers-service --force-new-deployment --region $AWS_REGION

echo "Deployment complete!"
echo "Service URL: $(terraform output -raw service_url)"