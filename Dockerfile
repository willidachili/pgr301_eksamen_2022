FROM maven:3.8.6-jdk-11 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -f pom.xml clean package

FROM adoptopenjdk/openjdk8
COPY --from=builder /app/target/onlinestore*.jar /app/application.jar
ENTRYPOINT ["java","-jar","/app/application.jar"]