# --- Etapa 1: Compilar con Maven y Java 21 ---
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Etapa 2: Ejecutar con Java 21 ---
# CORRECCIÓN: Usamos eclipse-temurin porque 'openjdk:21-jdk-slim' ya no existe/falla
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copiamos el JAR generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Exponemos el puerto (informativo para Render)
EXPOSE 8080

# Comando de inicio
ENTRYPOINT ["java","-jar","app.jar"]
