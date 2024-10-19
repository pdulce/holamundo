FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY target/holamundo-*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar", "--spring.profiles.active=prod"]
