# Stage 1: Build the application
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app

# Copy only the files needed for building (faster layers)
COPY ../sample-apps/spring-petclinic/pom.xml .
COPY ../sample-apps/spring-petclinic/mvnw .
COPY ../sample-apps/spring-petclinic/.mvn .mvn
COPY ../sample-apps/spring-petclinic/src src

# Build the application (skip tests for faster builds)
RUN ./mvnw clean package -DskipTests

# Stage 2: Create a lightweight runtime image
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/spring-petclinic-*.jar app.jar

# Set runtime configurations
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

# Health check (optional)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
