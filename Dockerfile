FROM openjdk:8-jdk-alpine
COPY target/spring-boot01-helloworld-1.0-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
