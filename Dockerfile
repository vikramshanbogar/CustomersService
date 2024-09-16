FROM amazoncorretto:21.0.4
LABEL authors="Vikram"
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} customers_service.jar
ENTRYPOINT ["java","-jar","/customers_service.jar"]
