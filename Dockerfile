# --- Etapa 1: Compilar con Maven y Java 21 ---
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Etapa 2: Ejecutar con Java 21 ---
# CORRECCIÓN: Usamos eclipse-temurin porque 'openjdk:21-jdk-slim' ya no existe/falla
FROM eclipse-temurin:21-jre
WORKDIR /app

# CORRECCIÓN IMPORTANTE: Tu proyecto genera un WAR, no un JAR.
# Copiamos cualquier archivo .war generado y lo renombramos a app.war
COPY --from=build /app/target/*.war app.war

# Exponemos el puerto (informativo para Render)
EXPOSE 8080

# Comando de inicio (Spring Boot puede ejecutar wars con java -jar)
ENTRYPOINT ["java","-jar","app.war"]
