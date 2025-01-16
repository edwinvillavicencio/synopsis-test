# Creacion
FROM eclipse-temurin:17-jdk-alpine as build

ARG NEXUS_PASSWORD

ENV NEXUS_PASSWORD=$NEXUS_PASSWORD

WORKDIR /workspace/app
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
COPY settings.xml .
COPY src src

RUN --mount=type=cache,target=/root/.m2 ./mvnw install -DskipTests -s settings.xml # Cache con BuildKit

RUN mkdir -p build/extracted && java -Djarmode=layertools -jar target/*.jar extract --destination target/extracted

# Ejecucion
FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
ARG EXTRACTED=/workspace/app/target/extracted
COPY --from=build ${EXTRACTED}/dependencies/ ./
COPY --from=build ${EXTRACTED}/spring-boot-loader/ ./
COPY --from=build ${EXTRACTED}/snapshot-dependencies/ ./
COPY --from=build ${EXTRACTED}/application/ ./

#Instalacion Agente
ARG version=2.9.0
ADD --chmod=644 https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v2.9.0/opentelemetry-javaagent.jar /usr/src/app/opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS=-javaagent:/usr/src/app/opentelemetry-javaagent.jar

ENTRYPOINT ["java","org.springframework.boot.loader.launch.JarLauncher","-javaagent:/usr/src/app/opentelemetry-javaagent.jar",".jar"]