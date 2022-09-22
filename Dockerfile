FROM maven:3.8.6-openjdk-17 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17
WORKDIR /app
COPY --from=build ./app/target/*.jar ./app.jar

ARG EUREKA_SERVER=eureka-host
ARG KEYCLOAK_SERVER=keycloak-host
ARG KEYCLOAK_PORT=8081

ENTRYPOINT java -jar -Dspring.profiles.active=production app.jar