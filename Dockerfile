# ---------- BUILD STAGE ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- RUNTIME STAGE ----------
FROM azul/zulu-openjdk:17-jre
WORKDIR /app
COPY --from=builder /app/target/springboot-eks.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
