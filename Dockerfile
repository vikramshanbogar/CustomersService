FROM eclipse-temurin:17-jdk-focal
LABEL authors="Vikram"
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} customers_service.jar
ENTRYPOINT ["java","-jar","/customers_service.jar"]
