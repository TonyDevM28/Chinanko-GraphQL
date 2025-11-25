# --- Etapa 1: Compilar con Maven y Java 21 (Versión alineada) ---
# Usamos una imagen de Maven más moderna que soporte Java 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Etapa 2: Ejecutar con Java 21 ---
FROM openjdk:21-jdk-slim
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]