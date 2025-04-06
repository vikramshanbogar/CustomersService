FROM amazoncorretto:21
LABEL authors="Vikram"
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} customers_service.jar
ENTRYPOINT ["java","-Xmx1000M" ,"-jar","/customers_service.jar"]
