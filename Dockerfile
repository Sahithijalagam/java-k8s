# FROM openjdk:11.0.3-jdk-slim
# COPY target/*.jar /var/www/app.jar
# EXPOSE 8080
# ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /var/www/app.jar" ]

FROM maven:3.5.2-jdk-9 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package
FROM openjdk:11.0.3-jdk-slim
COPY --from=build /usr/src/app/target/*.jar /var/www/app.jar 
EXPOSE 8080
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /var/www/app.jar" ]