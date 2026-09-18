FROM amazoncorretto:17-alpine

EXPOSE 8080
COPY target/*.jar /usr/app/.
WORKDIR /usr/app
ENTRYPOINT ["java", "-jar", "java-maven-app-1.0-SNAPSHOT.jar"]


